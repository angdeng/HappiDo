import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/current.dart';
import 'package:happido/common/design.dart';
import 'package:happido/common/sideMenu.dart';
import 'package:happido/models/task_list.dart';
import 'package:happido/ui/task_list_dialogue.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final dbRef = FirebaseFirestore.instance;
 // List<QueryDocumentSnapshot> lists = [];
  static Map<String, Task> taskMap = new Map<String, Task>();
  TaskListDialog tkdialog = new TaskListDialog();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _taskStream = FirebaseFirestore.instance
        .collection('tasks')
        .where('active', isEqualTo: true)
        .where('profileId', isEqualTo: Current.profile.id)
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .snapshots();

    return Theme(
      data: defaultTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text("✅ Tasks"),
        ),
        drawer: SideMenu(),
        body: StreamBuilder(
            stream: _taskStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot document){
                    Task tk;
                    if (taskMap.containsKey(document.id)) {
                      tk = taskMap[document.id];
                    }
                    else {
                      tk = new Task.fromMap(document.data(), document.id);
                      taskMap[document.id] = tk;
                    }
                    return Dismissible(
                        key: Key(document.id),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            Current.profile.addPoints(int.parse(tk.points));
                          }

                          tk.deactivate();
                        },
                        child: ListTile(
                          leading:  tk.completed==true? CircleAvatar(
                          backgroundColor: Colors.green,
                          ) :
                          CircleAvatar(
                            backgroundColor: Colors.pink,
                          ),
                          title: new Text(tk.name),
                          subtitle:
                          new Text(tk.assignee +" - Due By: " + tk.dueDate.toString() + " - Points:" + tk.points.toString()),
                          isThreeLine:true,
                          //onTap: () => Navigator.pushNamed(context, '/tasks'),
                          onLongPress: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                tkdialog.buildDialog(
                                    context,
                                    tk,
                                    false),
                          ),
                        ));
                    }).toList(),
                );
              }

              return CircularProgressIndicator();
            }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) =>
                  tkdialog.buildDialog(context, Task('', '', ' ', ' ', false), true),
            ),
        ),
      ),
      );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/current.dart';
import '../models/task_list.dart';
import 'package:intl/intl.dart';

class TaskListDialog {


  String id;
  final txtTask = TextEditingController();
  final txtAssignee = TextEditingController();
  final txtDueDate = TextEditingController();
  final txtPoints = TextEditingController();
  DateTime _selectedDate;

  DateTime selectedDate = DateTime.now();


  Widget buildDialog(BuildContext context, Task task, bool isNew) {
    if (!isNew) {
      txtTask.text = task.name;
      txtDueDate.text = task.dueDate;
      txtAssignee.text = task.assignee;
      txtPoints.text = task.points;
    }
    else {
      txtAssignee.text = Current.profile.name;
    }

    return AlertDialog(
        title: Text((isNew) ? 'New task' : 'Edit task'),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtTask,
                decoration: InputDecoration(hintText: 'Task')),
            TextField(
                controller: txtAssignee,
                decoration: InputDecoration(hintText: 'Assigned To')),
            TextField(

                decoration: InputDecoration(hintText: 'Due by'),
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
               _selectDate(context, isNew, task);
                },
              controller: txtDueDate),

            TextField(
              controller: txtPoints,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Points'),
            ),
            ElevatedButton(
                child: Text('Save Task'),
                onPressed: () {
                  if (isNew) {
                    insertTask(txtTask.text, txtAssignee.text, txtDueDate.text,
                        txtPoints.text);
                  } else {
                    updateTask(task, txtTask.text, txtAssignee.text,
                        txtDueDate.text, txtPoints.text);
                  }
                  Navigator.pop(context);
                })
          ]),
        ));
  }

  //This method saves the data in Firebase
  Future<DocumentReference> insertTask(String txtTask, String txtAssignedTo,
      String txtDueDate, String txtPoints) async {
    DocumentReference newDoc = await FirebaseFirestore.instance.collection(
        'tasks').add(<String, dynamic>{
      'task': txtTask,
      'active': true,
      'assignedTo': txtAssignedTo,
      'dueDate': txtDueDate,
      'points': txtPoints,
      'completed': false,
      'timestamp': DateTime
          .now()
          .millisecondsSinceEpoch,
      'createdBy': FirebaseAuth.instance.currentUser.displayName,
      'userId': FirebaseAuth.instance.currentUser.uid,
      'profileId': Current.profile.id,
    });

    this.id = newDoc.id;
    return newDoc;
  }

  Future<void> updateTask(Task task, String txtTask, String txtAssignedTo,
      String txtDueDate, String txtPoints) {
    task.name = txtTask;
    task.assignee = txtAssignedTo;
    task.points = txtPoints;

    return FirebaseFirestore.instance.doc('/tasks/' + task.id).update({
      'task': txtTask,
      'assignedTo': txtAssignedTo,
      'dueDate': txtDueDate,
      'points': txtPoints
    });
  }

 Future<void> _selectDate(BuildContext context, bool isNew, Task task) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.amberAccent,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.amber[500],
            ),
            child: child,
          );
        });
    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;

   txtDueDate
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: txtDueDate.text.length,
            affinity: TextAffinity.upstream));
   task.dueDate = txtDueDate.text;
     return FirebaseFirestore.instance.doc('/tasks/' + task.id).update({
        'dueDate': DateFormat.yMMMd().format(_selectedDate)
      });
    }
  }

}
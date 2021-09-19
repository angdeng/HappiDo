import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/current.dart';
import '../common/design.dart';
import '../common/sideMenu.dart';
import '../models/profile.dart';
import '../ui/profile_list_dialogue.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static Map<String, Profile> profileMap = new Map<String, Profile>();
  ProfileListDialog pfDialog = new ProfileListDialog();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _profileStream = FirebaseFirestore.instance
        .collection('profiles')
        .where('userId', isEqualTo: auth.currentUser.uid)
        .where('active', isEqualTo: true)
        .orderBy('name')
        .snapshots();

    return Theme(
      data: defaultTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('👨‍👩‍👧‍👦 Profile'),
        ),
        drawer: SideMenu(),
        body: StreamBuilder(
            stream: _profileStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    Profile pf;
                    if (profileMap.containsKey(document.id)) {
                      pf = profileMap[document.id];
                    } else {
                      pf = new Profile.fromMap(document.data(), document.id);
                      profileMap[document.id] = pf;
                    }

                    if (Current.profile == null) {
                      Current.profile = pf;
                    }

                    return Dismissible(
                        key: Key(document.id),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            pf.deactivate();
                          }
                        },
                        child: ListTile(
                          leading: Container(
                            height: 100,
                            width: 100,
                            child: pf.imageUrl != null
                              ? CircleAvatar(
                                backgroundImage: NetworkImage(pf.imageUrl),
                                radius: 150.0,
                              )
                              : CircleAvatar(
                                  child: Text(pf.name.substring(0, 1)),
                                  radius: 150.0,
                                ),),
                          title: new Text(pf.name,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800)),
                          subtitle: new Text(
                              'Available: ' + pf.pointsAvailable.toString(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade500)),
                          onTap: () {
                            Current.profile = pf;
                            Navigator.pushNamed(context, '/tasks');
                          },
                          onLongPress: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => pfDialog
                                .buildDialog(context, pf, auth.currentUser.uid),
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
                pfDialog.buildDialog(context, null, auth.currentUser.uid),
          ),
        ),
      ),
    );
  }
}

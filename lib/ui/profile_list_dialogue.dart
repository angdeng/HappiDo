import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../util/imageService.dart';

class ProfileListDialog {
  final txtName = TextEditingController();

  Widget buildDialog(BuildContext context, Profile pf, String userId) {
    bool isNew = pf == null;
    if (!isNew) {
      txtName.text = pf.name;
    }
    else {
      txtName.clear();
    }

    return AlertDialog(
        title: Text(isNew ? 'New Profile' : 'Edit Profile'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(hintText: 'Name')),
            ElevatedButton(
              child: Text('Upload Profile Picture'),
              onPressed: () {
                if (!isNew) {
                  pf.updateImagePath(
                      ImageService.uploadImage(pf.id, 'users/' + pf.userId + '/images/profiles/'));
                }
              }),
            ElevatedButton(
                child: Text('Save Profile'),
                onPressed: () {
                  if (isNew) {
                    pf = new Profile(txtName.text, userId);
                  } else {
                    pf.updateName(txtName.text);
                  }
                  Navigator.pop(context);
                })
          ]),
        ));
  }
}

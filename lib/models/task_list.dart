import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String name;
  String assignee;
  String dueDate;
  String points;
  bool completed = false;
  bool active = true;


  Task(this.name, this.assignee, this.dueDate, this.points, this.completed);

  Task.fromMap(Map<String, dynamic> data, String id) {
    this.name = data['task'];
    this.id = id;
    this.assignee = data['assignedTo'];
    this.points = data['points'];
    this.dueDate = data['dueDate'];
    this.completed = data['completed'];
    this.active = data['active'];
  }

  Future<void> deactivate() {
    return FirebaseFirestore.instance
        .doc('/tasks/' + this.id)
        .update({'active': false});
  }


}
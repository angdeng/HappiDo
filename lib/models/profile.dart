import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/imageService.dart';

const DEFAULT_PROFILE_IMAGE = 'defaults/images/profile.jpg';

class Profile {
  String name, id, userId, imagePath, imageUrl;
  int totalPointsEarned = 0, totalPointsSpent = 0, pointsAvailable = 0;
  bool active = true;

  Profile(String name, String userId) {
    this.name = name;
    this.userId = userId;
    create();
  }

  Profile.fromMap(Map<String, dynamic> data, String id) {
    this.name = data['name'];
    this.id = id;
    this.imagePath = data['imagePath'];
    this.userId = data['userId'];
    this.active = data['active'];

    this.totalPointsEarned = data['totalPointsEarned'];
    this.totalPointsSpent = data['totalPointsSpent'];
    this.pointsAvailable = totalPointsEarned - totalPointsSpent;

    getImageUrl();
  }

  Future<void> getImageUrl() async {
    this.imageUrl = await ImageService.getImageUrl(this.imagePath);
  }

  Future<DocumentReference> create() async {
    DocumentReference newDoc = await FirebaseFirestore.instance.collection('profiles').add({
      'name': this.name,
      'active': true,
      'imagePath' : DEFAULT_PROFILE_IMAGE,
      'totalPointsEarned': 0,
      'totalPointsSpent': 0,
      'userId': this.userId
    });

    this.id = newDoc.id;

    return newDoc;
  }

  Future<void> deactivate() {
    return FirebaseFirestore.instance
        .doc('/profiles/' + this.id)
        .update({'active': false});
  }

  Future<void> updateName(String newName) {
    this.name = newName;

    return FirebaseFirestore.instance
        .doc('/profiles/' + this.id)
        .update({'name': this.name});
  }

  Future<void> addPoints (int pointsToAdd) {
    this.totalPointsEarned += pointsToAdd;
    this.pointsAvailable = this.totalPointsEarned - this.totalPointsSpent;

    return FirebaseFirestore.instance
        .doc('/profiles/' + this.id)
        .update({'totalPointsEarned': this.totalPointsEarned});
  }

  Future<void> spendPoints (int pointsToSpend) {
    this.totalPointsSpent += pointsToSpend;
    this.pointsAvailable = this.totalPointsEarned - this.totalPointsSpent;

    return FirebaseFirestore.instance
        .doc('/profiles/' + this.id)
        .update({'totalPointsSpent': this.totalPointsEarned});
  }

  Future<void> updateImagePath(Future<String> newImagePath) async {
    this.imagePath = await newImagePath;
    getImageUrl();

    return FirebaseFirestore.instance
        .doc('/profiles/' + this.id)
        .update({'imagePath': this.imagePath});
  }
}

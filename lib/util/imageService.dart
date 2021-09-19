import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {

  static Future<String> getImageUrl(String filePath) async {
    return FirebaseStorage.instance.ref().child(filePath).getDownloadURL();
  }

  static Future<String> uploadImage(String fileName, String uploadDirectory) async {
    final _imagePicker = ImagePicker();
    PickedFile image;

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      if (image != null) {
        //Upload to Firebase
        File file = File(image.path);
        String imagePath = uploadDirectory + fileName;
        TaskSnapshot uploadSnapshot =
        await FirebaseStorage.instance.ref().child(imagePath).putFile(file);
        return FirebaseStorage.instance.ref().child(imagePath).fullPath;
      }
    }

    return null;
  }
}
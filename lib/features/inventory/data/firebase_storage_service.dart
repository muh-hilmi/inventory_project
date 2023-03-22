import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static Future<String> uploadImage(String uid, String imagePath) async {
    Reference storageRef = FirebaseStorage.instance.ref('$uid.jpg');
    File filePath = File(imagePath);

    try {
      await storageRef.putFile(filePath);
      final photoUrl = await storageRef.getDownloadURL();

      return photoUrl;
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}

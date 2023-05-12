import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //create the singleton instance
  factory FirebaseStorageHelper() => FirebaseStorageHelper._internal();
  FirebaseStorageHelper._internal();

  Future<String> uploadFile(File file, String folderName) async {
    final Reference reference = _firebaseStorage
        .ref()
        .child('$folderName/${DateTime.now()}.${file.path.split('.').last}');
    final UploadTask uploadTask = reference.putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteFile(String downloadUrl) async {
    final Reference reference = _firebaseStorage.refFromURL(downloadUrl);
    await reference.delete();
  }
}

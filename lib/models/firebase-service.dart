import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService{
  final storage = FirebaseStorage.instance;

  Future<void> uploadFile(File? file, String path, String id) async {
    final Reference ref = storage.ref().child('${path}/${id}.jpg');
    await ref.putFile(file!);
  }

  Future<String> getImageLink(String path) async {
    final ref = storage.ref().child(path+".jpg");
    return await ref.getDownloadURL();
  }

}

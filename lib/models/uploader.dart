import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';




class Uploader extends StatefulWidget {

  final File? file;

  const Uploader({super.key, this.file});

  @override
  State<Uploader> createState() => _UploaderState(file);
}

class _UploaderState extends State<Uploader> {
  File? image;

  _UploaderState(File? file) {
    image = file;
  }


  final storage = FirebaseStorage.instance;


  User userData = UserService.instance.user;
  Future<void> uploadFile() async {
      final Reference ref = storage.ref().child('profiles/${userData.id}.jpg');
      await ref.putFile(image!);
  }

  @override
  Widget build(BuildContext context) {

    return const Placeholder();
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';

final _picker = ImagePicker();

class ImageCapture extends StatefulWidget {
  const ImageCapture({super.key});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  late File _imageFile;
  Future<void> _pickImage() async{
    final XFile? selected = await _picker.pickImage(
      source: ImageSource.gallery
    );

    setState(() {
      _imageFile = File(selected!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TextButton(
            child: const Text("Upload"),
            onPressed: () async {
              _pickImage();
              final storage = FirebaseStorage.instance;
              User userData = UserService.instance.user;
              final Reference ref = storage.ref().child('profiles/${userData.id}.jpg');
              await ref.putFile(_imageFile);
            },
          ),
        ],
      ),
    );
  }
}

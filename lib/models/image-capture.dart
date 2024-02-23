import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/login-form.dart';
import 'package:market/main.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';
import 'package:market/navigation.dart';

final _picker = ImagePicker();

class ImageCapture extends StatefulWidget {
  const ImageCapture({super.key});

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File? _imageFile;

  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage() async{
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle any errors that occur during image picking
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TextButton(
            child: const Text("Upload"),
            onPressed: () async {
              await _pickImage();
              final storage = FirebaseStorage.instance;
              User userData = UserService.instance.user;
              final Reference ref = storage.ref().child('profiles/${userData.id}.jpg');
              await ref.putFile(_imageFile!);
              Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return Navigation();
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

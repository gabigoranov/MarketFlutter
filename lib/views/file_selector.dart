import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/services/firebase_service.dart';
import 'package:market/services/user_service.dart';
import 'package:market/models/user.dart';
import 'package:market/views/navigation.dart';

class ImageCapture extends StatefulWidget {
  final String path;
  const ImageCapture({super.key, required this.path});

  @override
  State<ImageCapture> createState() => _ImageCaptureState(path);
}

class _ImageCaptureState extends State<ImageCapture> {
  File? _imageFile;
  late String imagePath;
  _ImageCaptureState(String path){
    imagePath = path;
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

  Future<void> uploadProfileImage() async{
    await _pickImage();
    User userData = UserService.instance.user;
    final uploader = FirebaseService();
    uploader.uploadFile(_imageFile, imagePath, userData.email);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TextButton(
            child: const Text("Upload"),
            onPressed: () async {
              if(imagePath == "profiles"){
                await uploadProfileImage();
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context){
                  return Navigation(index: 0,);
                }),
                ModalRoute.withName('/'),
              );
            },
          ),
        ],
      ),
    );
  }
}

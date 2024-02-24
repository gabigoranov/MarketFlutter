import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/models/firebase-service.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';
import 'package:market/navigation.dart';

class ImageCapture extends StatefulWidget {
  String path;
  ImageCapture({super.key, required this.path});

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
    uploader.uploadFile(_imageFile, imagePath, userData.id);
  }

  Future<void> uploadOfferImage() async{
    await _pickImage();
    final uploader = FirebaseService();
    uploader.uploadFile(_imageFile, imagePath, UserService.instance.user.offers.last.id.toString());
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
              else if(imagePath == "offers"){
                await uploadOfferImage();
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context){
                  return Navigation();
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

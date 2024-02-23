import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/landing.dart';
import 'package:market/loading.dart';
import 'package:market/main.dart';
import 'package:market/models/user-service.dart';
import 'package:market/navigation.dart';

final storage = FlutterSecureStorage();

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  void authenticate() async{
    //await storage.delete(key: "user_data");
    final String? read = await storage.read(key: "user_data");
    if(read != null){
      final json = await jsonDecode(read);
      await UserService.instance.fetchUser(json[0], json[1]); //maybe remove
      await Future.delayed(const Duration(microseconds: 600));
      Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return Navigation();
        }),
      );
    }
    Navigator.push(context,
      MaterialPageRoute(builder: (context){
        return Landing();
      }),
    );
  }

  @override
  Widget build(BuildContext context){
    authenticate();
    return Loading();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/views/landing.dart';
import 'package:market/views/loading.dart';
import 'package:market/main.dart';
import 'package:market/services/user-service.dart';
import 'package:market/views/navigation.dart';

final storage = FlutterSecureStorage();

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool isAuthenticated = false;
  Future<void> authenticate() async{
    final String? read = await storage.read(key: "user_data");
    if(read != null){
      final json = await jsonDecode(read);
      await UserService.instance.login(json[0], json[1]); //maybe remove
      isAuthenticated = true;
    }
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(future: authenticate(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Loading();
        }
        else if(isAuthenticated){
          return Navigation();
        }
        return const Landing();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User userData = UserService.instance.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(userData.email),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';

class Soon extends StatelessWidget {
  const Soon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Coming Soon!"),
      ),
    );
  }
}


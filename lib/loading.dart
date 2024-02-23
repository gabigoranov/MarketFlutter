import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: SpinKitCubeGrid(
          color: Color(0xff5186c3),
          size: 75.0,
        ),
      ),
      color: const Color(0xffFAFAFA),
    );
  }
}
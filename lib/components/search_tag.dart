import 'dart:io';
import 'package:flutter/material.dart';


class SearchTag extends StatelessWidget {
  String text;
  SearchTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xffD3D3D3),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

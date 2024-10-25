import 'package:flutter/material.dart';

class DiscoverCategoryComponent extends StatelessWidget {
  final String title;
  final String imgURL;
  final int color;
  const DiscoverCategoryComponent({super.key, required this.title, required this.imgURL, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.11,
      decoration: BoxDecoration(
        color: Color(color).withOpacity(0.85),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0,
              blurRadius: 15,
              offset: Offset(5, 5), // Shadow moved to the right and bottom
            )
          ],
          borderRadius: BorderRadius.circular(25),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)
          ),
        ],
      ),
    );
  }
}
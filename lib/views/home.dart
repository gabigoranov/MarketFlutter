import 'package:flutter/material.dart';
import 'package:market/components/discover-category-component.dart';
import 'package:market/services/user-service.dart';
import 'package:market/views/landing.dart';

class Home extends StatefulWidget {
  Home({super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              DiscoverCategoryComponent(title: "Vegetables", imgURL: "#", color: 0xff26D156),
              const SizedBox(height: 10,),
              DiscoverCategoryComponent(title: "Fruits", imgURL: "#", color: 0xffF13A3A),
              const SizedBox(height: 10,),
              DiscoverCategoryComponent(title: "In season", imgURL: "#", color: 0xff56A8E4),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/home.dart';
import 'package:market/models/image-capture.dart';
import 'package:market/profile.dart';
import 'package:market/soon.dart';

final storage = FlutterSecureStorage();

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  List<Widget> pages = [
    Soon(),
    Soon(),
    Soon(),
    Soon(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFFFFFFF),
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary, size: 34),
          selectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          selectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            // Handle navigation bar item tap
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, ),
              label: "Discover",
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, ),
              label: "New",
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.send, ),
              label: "Message",
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, ),
              label: "Profile",
      
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/services/user_service.dart';
import 'package:market/views/discover.dart';
import 'package:market/views/history.dart';
import 'package:market/views/home.dart';
import 'package:market/views/profile.dart';

final storage = FlutterSecureStorage();
PageController _pageController = PageController();

class Navigation extends StatefulWidget {
  final int index;
  final String text;
  const Navigation({super.key, required this.index, this.text = ""});
  @override
  State<Navigation> createState() => _NavigationState(index, text);
}

class _NavigationState extends State<Navigation> {
  _NavigationState(int index, String text){
    _currentIndex = index;
    text = text;
  }

  String text = "";
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              Home(),
              Discover(text: text,),
              History(),
              Profile(userData: UserService.instance.user),
            ],
          ),
        ),
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
            icon: Icon(CupertinoIcons.compass, ),
            label: "Discover",
    
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, ),
            label: "History",
    
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, ),
            label: "Profile",
    
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/services/authentication_wrapper.dart';
import 'package:market/views/cart-view.dart';
import 'package:market/views/landing.dart';
import 'package:market/views/loading.dart';
import 'package:market/services/user_service.dart';
import 'package:market/models/user.dart';
import 'package:market/services/firebase_service.dart';

class Profile extends StatefulWidget {
  final User userData;

  const Profile({super.key, required this.userData});

  @override
  State<Profile> createState() => _ProfileState(userData);
}

class _ProfileState extends State<Profile> {
  final storage = FirebaseStorage.instance.ref();
  final GlobalKey _key = GlobalKey();
  String networkImageURL = '';
  late User userData;
  bool _isPasswordVisible = false;

  _ProfileState(User user) {
    userData = user;
  }

  List<Widget> userOffers = [];

  void cacheImage(String path) async {
    await precacheImage(NetworkImage(path), context);
  }

  Future<String> getData() async {
    await Future.delayed(const Duration(milliseconds: 500), () async {
      FirebaseService fbService = FirebaseService();
      networkImageURL =
          await fbService.getImageLink("profiles/${userData.email}");
      userOffers = [];
    });
    return networkImageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 14,),
                        Text(
                          '${userData.firstName} ${userData.lastName}',
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FutureBuilder<String>(
                          future: getData(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return CircleAvatar(
                                radius: 85,
                                backgroundColor: Colors.black87,
                                backgroundImage: NetworkImage(networkImageURL),
                              );
                            }else{
                              return const CircleAvatar(
                                backgroundColor: Colors.black87,
                                radius: 85,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 12,),
                        Text(userData.town, style: const TextStyle(color: Colors.black, fontSize: 24),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
                          child: Text(userData.description, style: const TextStyle(color: Colors.grey, fontSize: 20),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22,),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CartView();
                          })
                        );
                      },
                      style: const ButtonStyle(
                        iconSize: WidgetStatePropertyAll(32),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
        
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shadowColor: Colors.white,
                          side: const BorderSide(color: Colors.blue, width: 2)
                        ),
                        child: const Text("Edit Profile"),
                      
                      ),
                    ),
                    const SizedBox(width: 12,),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        showMenu(
                          context: context,
                          position: const RelativeRect.fromLTRB(100, 470, 0, 50),
                          items: [ const PopupMenuItem<String>( value: 'delete', child: Text('Delete'), ), const PopupMenuItem<String>( value: 'logout', child: Text('Logout'), ), ],
                        ).then((value) async {
                          if(value == "delete"){
                            await UserService.instance.delete(userData.id);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Landing()),
                              (Route<dynamic> route) => false,
                            );
        
                          }
                          else if(value == "logout"){
                            UserService.instance.logout();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Landing()),
                                  (Route<dynamic> route) => false,
                            );
                          }
                        });
                      },
                      style: const ButtonStyle(
                        iconSize: WidgetStatePropertyAll(32),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22,),
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, size: 30, color: Colors.blue,),
                      title: Text("${userData.firstName} ${userData.lastName}",
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.calendar_month, size: 30, color: Colors.blue),
                      title: Text("Age: ${userData.age}",
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.phone, size: 30, color: Colors.blue),
                      title:
                      Text(userData.phoneNumber, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.email, size: 30, color: Colors.blue),
                      title: Text(userData.email, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.key, size: 30, color: Colors.blue),
                      title: Text(
                        _isPasswordVisible ? userData.password : '••••••••••',
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: IconButton( icon: Icon( _isPasswordVisible ? Icons.visibility_off : Icons.visibility, color: Colors.blue, ), onPressed: () { setState(() { _isPasswordVisible = !_isPasswordVisible; }); }, ),
                    ),
        
                  ),
                ],
              )
        
            ],
          ),
        ),
      ),
    );
  }
}

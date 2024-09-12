import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/components/offer-component.dart';
import 'package:market/views/landing.dart';
import 'package:market/views/loading.dart';
import 'package:market/services/user-service.dart';
import 'package:market/models/user.dart';
import 'package:market/services/firebase-service.dart';


class Profile extends StatefulWidget {
  User userData;
  Profile({super.key, required this.userData});

  @override
  State<Profile> createState() => _ProfileState(userData);
}

class _ProfileState extends State<Profile> {
  final storage = FirebaseStorage.instance.ref();
  String networkImageURL = '';
  late User userData;
  _ProfileState(User user){
    userData = user;
  }
  List<Widget> userOffers = [];


  Future<String> getData() async{
    await Future.delayed(const Duration(milliseconds: 500), () async{
      FirebaseService fbService = FirebaseService();
      networkImageURL = await fbService.getImageLink("profiles/${userData.email}");
      userOffers = [];
    });
    return networkImageURL;

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(); // Show a loading indicator
          } else if (snapshot.hasError) {
            return const Text('Error loading image'); // Handle errors
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0,0,0,16),
                margin:  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 400,
                            //maximum width set to 100% of width
                          ),
                          child: Container(

                            height: MediaQuery.of(context).size.height*0.6,
                            child: Image.network(networkImageURL,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image is fully loaded
                                  return child;
                                } else {
                                  // Display a loading indicator (e.g., CircularProgressIndicator)
                                  return const Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const[
                                BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 2.0,
                                  blurRadius: 2,
                                  offset: Offset(2, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                              "${userData.firstName} ${userData.lastName}",
                              style: TextStyle(fontSize: 18.0, color: Theme.of(context).colorScheme.background),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Visibility(
                            visible: userData.id == UserService.instance.user.id,
                            child: PopupMenuButton<String>(
                              icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary, size: 34,), // The three lines icon
                              onSelected: (String result) {

                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'logout',
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context){
                                          return const Landing();
                                        }),
                                        ModalRoute.withName('/'),
                                      );
                                    },
                                    child: const Text('Logout')
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: TextButton(
                                    onPressed: () async{
                                      await UserService.instance.delete(UserService.instance.user.id);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context){
                                          return const Landing();
                                        }),
                                        ModalRoute.withName('/'),
                                      );
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset("assets/clouds.png",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 115,
                            decoration: BoxDecoration(
                              color: const Color(0xff40B886),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const[
                                BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 0,
                                  blurRadius: 0.6,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              child: Center(child: Icon(CupertinoIcons.checkmark_alt, color: Colors.white, size: 26,)),
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child:  Container(
                              height: 115,
                              decoration: BoxDecoration(
                                color: const Color(0xffFEFEFE),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const[
                                  BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0,
                                    blurRadius: 0.6,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(child: Icon(CupertinoIcons.shopping_cart, color: Theme.of(context).colorScheme.primary, size: 54,)),
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(
                            child: Container(
                              height: 115,
                              decoration: BoxDecoration(
                                color: const Color(0xffFEFEFE),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const[
                                  BoxShadow(
                                    color: Colors.black38,
                                    spreadRadius: 0,
                                    blurRadius: 0.6,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                child: Center(child: Icon(CupertinoIcons.paperplane_fill, color: Theme.of(context).colorScheme.primary, size: 54,)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Container(
                            height: 115,
                            decoration: BoxDecoration(
                              color: const Color(0xff40B886),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const[
                                BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 0,
                                  blurRadius: 0.6,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Center(child: Icon(CupertinoIcons.star, color: Colors.white, size: 26,)),
                                  Text("${userData.rating}", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Align(alignment: Alignment.centerLeft, child: Text("Selling:", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 34, fontWeight: FontWeight.w400),)),
                    ),
                    Column(
                      children: userOffers,
                    )

                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

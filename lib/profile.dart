import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:market/Subviews/offer.dart';
import 'package:market/loading.dart';
import 'package:market/models/user-service.dart';
import 'package:market/models/user.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final storage = FirebaseStorage.instance.ref();
  String networkImageURL = '';
  User userData = UserService.instance.user;
  List<Widget> userOffers = [];


  Future<String> getData() async{
    final profiles = storage.child("profiles");
    final profileRef = profiles.child("${userData.id}.jpg");
    networkImageURL = await profileRef.getDownloadURL();

    userOffers = [];
    for(int i = 0; i < userData.offers.length; i++){
      userOffers.add(OfferView(offer: userData.offers[i]));
      userOffers.add(const SizedBox(height: 10,));
    }

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
            final imageUrl = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0,0,0,16),
                margin:  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 350,
                            //maximum width set to 100% of width
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.6,
                            child: Image.network(networkImageURL,
                              width: double.infinity,
                              fit: BoxFit.cover,
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
              
                            child: Text("${userData.firstName} ${userData.lastName}", style: TextStyle(fontSize: 18.0, color: Theme.of(context).colorScheme.background),),
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
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
                                color: const Color(0xffEEEEEE),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
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
                                color: const Color(0xffEEEEEE),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
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

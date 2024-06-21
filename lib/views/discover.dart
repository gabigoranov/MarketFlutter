import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/components/discover-category-component.dart';
import 'package:market/components/offer-component.dart';
import 'package:market/views/loading.dart';
import 'package:market/models/offer.dart';
import 'package:market/services/user-service.dart';
import 'package:market/models/user.dart';

final dio = Dio();

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  List<Widget> offers = [];
  List<Widget> searched = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  User userData = UserService.instance.user;

  Future<void> getData() async{
    String url = 'https://farmers-market.somee.com/api/Offers/getAll';
    Response<dynamic> response = await dio.get(url);
    offers = [];
    for(int i = 0; i < response.data.length; i++){
      offers.add(OfferComponent(offer: Offer.fromJson(response.data[i])));
      offers.add(const SizedBox(height: 10,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: getData(),
              builder:  (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading(); // Show a loading indicator
                } else if (snapshot.hasError) {
                return const Text('Error loading image'); // Handle errors
                } else {
                  if(searched.isNotEmpty){
                    offers = searched;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.75,
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Search something here',
                                      contentPadding: EdgeInsets.all(12.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async{
                                    String input = searchController.value.text;
                                    String url = "https://www.farmers-market.somee.com/api/Offers/search?input=$input&prefferedTown=${userData.town}";
                                    Response<dynamic> response = await dio.get(url);
                                    setState(() {
                                      searched = [];
                                      for(int i = 0; i < response.data.length; i++){
                                        searched.add(OfferComponent(offer: Offer.fromJson(response.data[i])));
                                        searched.add(const SizedBox(height: 10,));
                                      }
                                    });
                                  },
                                  icon: const Icon(CupertinoIcons.search),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 22,),
                        Column(children: offers,),
                      ],
                    ),
                  );
                }
              }
            ),
            
          ]
        ),
      ),
    );
  }
}

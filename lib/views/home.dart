import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/components/discover_category_component.dart';
import 'package:market/components/history_order_component.dart';
import 'package:market/views/navigation.dart';

import '../models/purchase.dart';
import '../services/purchase-service.dart';

class Home extends StatefulWidget {
  const Home({super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  late List<Purchase> orders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orders =  PurchaseService.instance.getPurchases().reversed.take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<HistoryOrderComponent> widgets = orders.map((element) {return HistoryOrderComponent(order: element);}).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      //search
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.75,
                            child: Form(
                              child: TextFormField(
                                key: _formKey,
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search something here',
                                  contentPadding: const EdgeInsets.all(12.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(color: Colors.white, width: 3.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => Navigation(index: 1, text: searchController.text,)),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            icon: const Icon(CupertinoIcons.search),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const DiscoverCategoryComponent(title: "Vegetables", imgURL: "assets/discover-vegetables.jpg", color: 0xff26D156),
                      const SizedBox(height: 10,),
                      const DiscoverCategoryComponent(title: "Fruits", imgURL: "assets/discover-fruits.jpg", color: 0xffF13A3A),
                      const SizedBox(height: 10,),
                      const DiscoverCategoryComponent(title: "Dairy", imgURL: "assets/discover-dairy.jpg", color: 0xff56A8E4),
                      const SizedBox(height: 10,),
                      const DiscoverCategoryComponent(title: "Meat", imgURL: "assets/discover-meat.jpg", color: 0xffFFFAA8),
                      //tags
                      const SizedBox(height: 30,),

                    ],
                  ),
                  const Text("Recent Orders:"),
                  Column(
                    children: widgets,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

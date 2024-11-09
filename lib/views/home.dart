import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/components/discover_category_component.dart';
import 'package:market/components/search_tag.dart';
import 'package:market/views/navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      DiscoverCategoryComponent(title: "Vegetables", imgURL: "#", color: 0xff26D156),
                      const SizedBox(height: 10,),
                      DiscoverCategoryComponent(title: "Fruits", imgURL: "#", color: 0xffF13A3A),
                      const SizedBox(height: 10,),
                      DiscoverCategoryComponent(title: "Produce", imgURL: "#", color: 0xff56A8E4),
                      const SizedBox(height: 10,),
                      DiscoverCategoryComponent(title: "Meat", imgURL: "#", color: 0xffFFFAA8),
                      //tags
                      const SizedBox(height: 30,),

                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SearchTag(text: "Fresh"),

                        ],
                      ),
                    ]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

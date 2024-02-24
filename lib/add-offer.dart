import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:market/models/offer.dart';
import 'package:market/models/user-service.dart';
import 'package:market/navigation.dart';

class AddOfferView extends StatefulWidget {
  const AddOfferView({super.key});

  @override
  State<AddOfferView> createState() => _AddOfferViewState();
}

class _AddOfferViewState extends State<AddOfferView> {
  final userData = UserService.instance.user;
  String? selectedOfferType = '1';
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController isInSeason = TextEditingController();
    TextEditingController offerType = TextEditingController();

    Future<void> addOffer(Offer offer) async{
      const url = 'https://farmers-market.somee.com/api/Offers/add';
      //print(jsonEncode(user).toString());
      await dio.post(url, data: jsonEncode(offer));

      //print(response);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Offer'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,

        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter a title!";
                    }
                    else if(value.length > 24){
                      return "Max length is 24";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0,),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter a price!";
                    }
                    try{
                      double parsed = double.parse(value);
                      if(parsed <= 0){
                        return "The price must be more than 0!";
                      }
                    }
                    catch(e){
                      return "The price must be a number!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0,),
                DropdownButton<String>(
                  value: selectedOfferType,
                  items: const[
                    DropdownMenuItem(value: '1', child: Text('Apples'), ),
                    DropdownMenuItem(value: '2', child: Text('Lemons'), ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedOfferType = value;
                    });
                  },
                ),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await addOffer(Offer(id: -1, title: titleController.value.text,
                                    pricePerKG: double.parse(priceController.value.text),
                                    ownerId: userData.id,
                                    offerTypeId: int.parse(selectedOfferType!),
                                ));
                                await UserService.instance.fetchUser(userData.email, userData.password);
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return Navigation();
                                  }),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              shadowColor: Colors.black,
                              elevation: 4.0,
                            ),
                            child: Text("Add Offer", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

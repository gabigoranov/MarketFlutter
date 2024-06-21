import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:market/views/file-selector.dart';
import 'package:market/models/offer.dart';
import 'package:market/services/user-service.dart';
import 'package:market/views/navigation.dart';

class AddOfferView extends StatefulWidget {
  const AddOfferView({super.key});

  @override
  State<AddOfferView> createState() => _AddOfferViewState();
}

class _AddOfferViewState extends State<AddOfferView> {
  final userData = UserService.instance.user;
  String? selectedOfferType = '1';
  String? selectedOfferTown = 'Montana';
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> dropdownKey = GlobalKey<FormState>();
    final GlobalKey<FormState> townDropdownKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();

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
                  controller: descriptionController,

                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter a description!";
                    }
                    else if(value.length > 300){
                      return "Max length is 300";
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
                  key: dropdownKey,
                  value: selectedOfferType,
                  items: const[
                    DropdownMenuItem(value: '1', child: Text('Apples'), ),
                    DropdownMenuItem(value: '2', child: Text('Lemons'), ),
                    DropdownMenuItem(value: '3', child: Text('Eggs'), ),
                    DropdownMenuItem(value: '4', child: Text('Bananas'), ),
                    DropdownMenuItem(value: '5', child: Text('Grapes'), ),
                    DropdownMenuItem(value: '6', child: Text('Oranges'), ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedOfferType = value;
                    });
                  },
                ),
                const SizedBox(height: 25,),
                DropdownButton<String>(
                  key: townDropdownKey,
                  value: selectedOfferTown,
                  items: const[
                    DropdownMenuItem(value: 'Montana', child: Text('Montana'), ),
                    DropdownMenuItem(value: 'Sofia', child: Text('Sofia'), ),
                    DropdownMenuItem(value: 'Burgas', child: Text('Burgas'), ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedOfferTown = value;
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
                                await addOffer(Offer(id: -1,
                                    title: titleController.value.text,
                                    town: selectedOfferTown!,
                                    description: descriptionController.value.text,
                                    pricePerKG: double.parse(priceController.value.text),
                                    ownerId: userData.id,
                                    offerTypeId: int.parse(selectedOfferType!),
                                ));
                                await UserService.instance.login(userData.email, userData.password);
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return ImageCapture(path: "offers");
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

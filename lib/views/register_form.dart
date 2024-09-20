import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:market/views/file_selector.dart';
import 'package:market/services/user_service.dart';
import 'package:market/models/user.dart';

final dio = Dio();

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _firstNameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _ageController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _townController = TextEditingController();

    Future<void> registerUser(User user) async{
      const url = 'https://farmers-market.somee.com/api/Users/add/';
      print(jsonEncode(user).toString());
      await dio.post(url, data: jsonEncode(user));

      //print(response);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Form'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter a valid name!";
                      }
                      else if(value.length > 12){
                        return "Max length is 12";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter a valid name!";
                      }
                      else if(value.length > 12){
                        return "Max length is 12";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter a valid age!";
                      }
                      try{
                        int parsed = int.parse(value);
                        if(parsed < 18){
                          return "Must be at least 18 years old!";
                        }
                      }
                      catch(e){
                        return "Please enter a valid age!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (value){
                        if(value == null || value.isEmpty){
                          return "Enter a valid phone number!";
                        }
                        return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter a valid description!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter a valid email!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _townController,
                    decoration: const InputDecoration(
                      labelText: 'Town',
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter a valid Town!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Enter a valid password!";
                      }
                      else if(value.length < 8){
                        return "Password must be at least 8 characters!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await registerUser(User(
                                      id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                      firstName: _firstNameController.value.text,
                                      lastName: _lastNameController.value.text,
                                      age:  int.parse(_ageController.value.text),
                                      description: _descriptionController.value.text,
                                      password: _passwordController.value.text,
                                      phoneNumber: _phoneController.value.text,
                                      rating: 0,
                                      town: _townController.value.text,
                                      email: _emailController.value.text,
                                      isSeller: false,
                                      boughtOrders: [],
                                  ));
                                  await UserService.instance.login(_emailController.value.text, _passwordController.value.text);
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return ImageCapture(path: "profiles");
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
                              child: Text("Register", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24),),
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
      ),
    );
  }
}

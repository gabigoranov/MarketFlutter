import 'dart:convert';

import 'package:market/models/offer.dart';

class User{
  String id;
  String firstName;
  String lastName;
  int age;
  bool isVerified;
  String email;
  String phoneNumber;
  String password;
  String description;
  List<Offer> offers;

  // Constructor
  User({required this.id, required this.firstName, required this.lastName,
        required this.age, required this.isVerified, required this.email,
        required this.phoneNumber, required this.password, required this.description,
        required this.offers});

  // Factory constructor to create a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    List<Offer> converted = [];
    for(int i = 0; i < json['offers'].length; i++){
      converted.add(Offer.fromJson(json['offers'][i]));
    }
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int,
      isVerified: json['isVerified'] as bool,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      description: json['description'] as String,
      offers: converted,

    );
  }

  // Method to convert User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'isVerified': isVerified,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'description': description,
      'offers': offers,
    };
  }
}
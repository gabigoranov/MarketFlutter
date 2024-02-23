import 'dart:convert';

import 'package:market/models/offer.dart';

class User{
  String id;
  String firstName;
  String lastName;
  int age;
  String email;
  String phoneNumber;
  String password;
  String description;
  List<Offer> offers;
  int rating;

  // Constructor
  User({required this.id, required this.firstName, required this.lastName,
        required this.age, required this.email, this.rating = 0,
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
      email: json['email'] as String,
      rating: json['rating'] as int,
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
      'email': email,
      'rating': rating,
      'phoneNumber': phoneNumber,
      'password': password,
      'description': description,
      'offers': offers,
    };
  }
}
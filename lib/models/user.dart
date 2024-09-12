
import 'package:market/models/offer.dart';

import 'order.dart';

class User{
  String id;
  String firstName;
  String lastName;
  int age;
  String email;
  String phoneNumber;
  String password;
  String description;
  double rating;
  String town;
  bool isSeller;
  List<Order> boughtOrders;

  // Constructor
  User({required this.id, required this.firstName, required this.lastName,
        required this.age, required this.email, this.rating = 0,
        required this.phoneNumber, required this.password, required this.description,
        required this.town, required this.isSeller, required this.boughtOrders});

  // Factory constructor to create a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    List<Order> converted = [];
    print(json);
    if(json['boughtOrders'].length > 0){
      for(int i = 0; i < json['boughtOrders'].length; i++){
        converted.add(Order.fromJson(json['boughtOrders'][i]));
      }
    }
    User res = User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
      rating: json['rating']+.0 as double,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      description: json['description'] as String,
      town: json['town'] as String,
      isSeller: json['isSeller'] as bool,
      boughtOrders: converted,
    );
    return res;
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
      'town': town,
      'isSeller': isSeller,
    };
  }
}
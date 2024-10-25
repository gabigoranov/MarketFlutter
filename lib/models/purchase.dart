
import 'dart:convert';

import 'package:market/models/order.dart';

class Purchase{
  int id;
  double price;
  String? address;
  String buyerId;
  DateTime? dateOrdered;
  DateTime? dateDelivered;
  bool isDelivered;
  List<Order>? orders;

  Purchase({ this.id=0, this.price=0,
    this.address, required this.buyerId, this.dateOrdered, this.dateDelivered, required this.isDelivered, this.orders = null});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    List<Order> converted = [];
    print(json);
    if(json['orders'].length > 0){
      for(int i = 0; i < json['orders'].length; i++){
        converted.add(Order.fromJson(json['orders'][i]));
      }
    }
    Purchase res = Purchase(
      id: json['id'] as int,
      price: json['price']+.0 as double,
      address: json['address'] as String,
      buyerId: json['buyerId'] as String,
      dateOrdered: DateTime.parse(json['dateOrdered']),
      dateDelivered: json['dateDelivered'] != null ? DateTime.parse(json['dateDelivered']) : null,
      isDelivered: json['isDelivered'] as bool,
      orders: converted,
    );
    return res;
  }

  // Method to convert User instance to a JSON map
  Map<String, dynamic> toJson() {
    List<Order> conv = [];
    for(var order in orders!){
      conv.add(order);
    }
    return {
      'id': id,
      'price': price,
      'address': address,
      'buyerId': buyerId,
      'orders': conv,
    };
  }
}
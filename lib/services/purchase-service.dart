import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:market/models/purchase.dart';
import 'package:market/services/cart-service.dart';
import 'package:market/services/user_service.dart';
import '../models/order.dart';

final dio = Dio();

final class PurchaseService {
  factory PurchaseService() {
    return instance;
  }
  PurchaseService._internal();
  static final PurchaseService instance = PurchaseService._internal();


  Future<String> purchase(Purchase model) async{
    const url = 'https://farmers-api.runasp.net/api/Purchases/add/';
    Response<dynamic> response = await dio.post(url, data: model.toJson());
    await CartService.instance.delete();
    UserService.instance.reload();
    return response.data;
  }

  List<Purchase> getPurchases(){
    return UserService.instance.user.boughtOrders;
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/models/offer.dart';
import 'package:market/services/user-service.dart';
import 'package:market/views/login-form.dart';
import 'package:market/models/user.dart';

final storage = FlutterSecureStorage();
final dio = Dio();

final class OfferService {
  factory OfferService() {
    return instance;
  }
  OfferService._internal();
  static final OfferService instance = OfferService._internal();


  Future<String> delete(int id) async{
    final url = 'https://farmers-market.somee.com/api/Offers/delete?id=$id';
    Response<dynamic> response = await dio.delete(url);
    UserService.instance.reload();
    return response.data;
  }

  Future<String> edit(Offer offer) async{
    const url = 'https://farmers-market.somee.com/api/edit/';
    Response<dynamic> response = await dio.post(url, data: jsonEncode(offer));
    return response.data;
  }
}

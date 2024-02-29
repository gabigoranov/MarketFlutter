import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/login-form.dart';
import 'package:market/models/user.dart';

final storage = FlutterSecureStorage();
final dio = Dio();

final class UserService {
  factory UserService() {
    return instance;
  }

  UserService._internal();

  static final UserService instance = UserService._internal();

  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
  }

  Future<void> fetchUser(String email, String password) async{
    final url = 'https://farmers-market.somee.com/api/Users/login?email=$email&password=$password';
    Response<dynamic> response = await dio.get(url);
    User user =  User.fromJson(response.data);

    await storage.write(key: "user_data", value: jsonEncode([user.email, user.password]));
    _user = user;
  }

  Future<User> getWithId(String id) async{
    final url = 'https://farmers-market.somee.com/api/Users/getWithId?id=$id';
    Response<dynamic> response = await dio.get(url);
    User user =  User.fromJson(response.data);
    return user;
  }

}

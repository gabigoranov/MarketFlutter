import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  Future<void> login(String email, String password) async{
    final url = 'https://farmers-market.somee.com/api/users/login?email=$email&password=$password';
    Response<dynamic> response = await dio.get(url);

    User user =  User.fromJson(response.data);

    await storage.write(key: "user_data", value: jsonEncode([user.email, user.password]));
    _user = user;
  }

  Future<void> reload() async{
    final url = 'https://farmers-market.somee.com/api/Users/login?email=${this.user.email}&password=${this.user.password}';
    Response<dynamic> response = await dio.get(url);
    User user =  User.fromJson(response.data);
    _user = user;
  }

  Future<User> getWithId(String id) async{
    final url = 'https://farmers-market.somee.com/api/Users/getWithId?id=$id';
    Response<dynamic> response = await dio.get(url);
    User user =  User.fromJson(response.data);
    return user;
  }

  Future<String> delete(String id) async{
    final url = 'https://farmers-market.somee.com/api/Users/delete?id=$id';
    print(url);
    Response<dynamic> response = await dio.get(url);
    return response.data;
  }

}

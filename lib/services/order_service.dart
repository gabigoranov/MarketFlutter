import 'package:dio/dio.dart';
import 'package:market/services/user_service.dart';
import '../models/order.dart';

final dio = Dio();

final class OrderService {
  factory OrderService() {
    return instance;
  }
  OrderService._internal();
  static final OrderService instance = OrderService._internal();


  Future<String> order(Order model) async{
    const url = 'https://farmers-market.somee.com/api/Orders/add/';
    Response<dynamic> response = await dio.post(url, data: model.toJson());
    UserService.instance.reload();
    return response.data;
  }

  List<Order> getOrders(){
    return UserService.instance.user.boughtOrders;
  }
}

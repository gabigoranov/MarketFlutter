import 'package:flutter/material.dart';
import 'package:market/components/history_order_component.dart';
import 'package:market/models/order.dart';
import 'package:market/services/order_service.dart';

class History extends StatelessWidget {
  final List<Order> orders = OrderService.instance.getOrders();
  final List<HistoryOrderComponent> widgets = [];

  History({super.key});

  @override
  Widget build(BuildContext context) {
    for(int i = 0; i < orders.length; i++){
      widgets.add(HistoryOrderComponent(order: orders[i]));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: widgets,
      )
    );
  }
}


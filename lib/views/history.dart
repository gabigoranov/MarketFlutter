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
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width*0.9,
          child: SingleChildScrollView(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Order History:", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),),
                Column(
                    children: widgets.reversed.toList(),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


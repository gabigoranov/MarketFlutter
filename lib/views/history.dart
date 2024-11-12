import 'package:flutter/material.dart';
import 'package:market/components/history_order_component.dart';
import 'package:market/models/order.dart';
import 'package:market/services/order_service.dart';
import 'package:market/services/purchase-service.dart';

import '../models/purchase.dart';

class History extends StatelessWidget {
  final List<Purchase> orders = PurchaseService.instance.getPurchases();
  final List<HistoryOrderComponent> widgets = [];

  History({super.key});

  @override
  Widget build(BuildContext context) {
    for(int i = 0; i < orders.length; i++){
      widgets.add(HistoryOrderComponent(order: orders[i]));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Align(alignment: Alignment.center, child: Text("Order History", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),)),
        shadowColor: Colors.black87,
        elevation: 0.4,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: widgets.reversed.toList(),
          )
        ),
      ),
    );
  }
}


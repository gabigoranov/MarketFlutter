import 'package:flutter/material.dart';
import '../models/order.dart';

class HistoryOrderComponent extends StatelessWidget {
  final Order order;
  const HistoryOrderComponent({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.1,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 0,
            blurRadius: 0.6,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(order.price.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.tertiary),),
                Text("${order.address}")
              ],
            )

          ],
        ),
      ),
    );
  }
}

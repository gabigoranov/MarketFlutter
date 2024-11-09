import 'package:flutter/material.dart';

import '../models/order.dart';
class CartComponent extends StatelessWidget {
  final Order order;
  final BorderRadius borderRadius;
  final color;
  const CartComponent({super.key, required this.order, required this.borderRadius, this.color = Colors.white});

  @override
  Widget build(BuildContext context, ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
              color: color,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(5, 5), // Shadow moved to the right and bottom
                )
              ],
              borderRadius: borderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${order.quantity}KG of ${order.title.split(" ")[order.title.split(" ").length-1]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.tertiary),),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${order.address}"),
                            const SizedBox(width:  22,),
                            Text("${order.price} BGN."),
                          ],
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../models/order.dart';

class HistoryOrderComponent extends StatelessWidget {
  final Order order;
  HistoryOrderComponent({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(5, 5), // Shadow moved to the right and bottom
                )
              ],
              borderRadius: BorderRadius.circular(25),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/models/offer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market/models/user.dart';


class OfferView extends StatelessWidget {
  Offer offer;
  OfferView({super.key, required this.offer});
  Map<int, Widget> offerTypes = {
    1: SvgPicture.asset(
      'assets/icons/apple.svg',
      width: 30,  // Set the desired width
      height: 30, // Set the desired height
      color: Colors.white, // Optionally set a color
    ),
    2: SvgPicture.asset(
      'assets/icons/lemon.svg',
      width: 30,  // Set the desired width
      height: 30, // Set the desired height
      color: Colors.white, // Optionally set a color
    ),
  };
  Map<int, Color> colors = {
    1: const Color(0xffF67979),
    2: const Color(0xffFFE380),
  };


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
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: colors[offer.offerTypeId],
                borderRadius: BorderRadius.circular(50),
                boxShadow: const[
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 1.0,
                    blurRadius: 0.6,
                    offset: Offset(0.5, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Center(child: offerTypes[offer.offerTypeId]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(offer.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),),
                Text("${offer.pricePerKG}lv/kg ") //TODO: add town to user class (update api and db)
              ],
            )

          ],
        ),
      ),
    );
  }
}
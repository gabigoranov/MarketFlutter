import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:market/models/offer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market/views/offer_view.dart';


class OfferComponent extends StatelessWidget {
  final Offer offer;
  OfferComponent({super.key, required this.offer});
  final Map<int, Widget> offerTypes = {
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
    3: SvgPicture.asset(
      'assets/icons/eggs.svg',
      width: 30,  // Set the desired width
      height: 30, // Set the desired height
      color: Colors.white, // Optionally set a color
    ),
    4: SvgPicture.asset(
      'assets/icons/bananas.svg',
      width: 30,  // Set the desired width
      height: 30, // Set the desired height
      color: Colors.white, // Optionally set a color
    ),
    5: SvgPicture.asset(
      'assets/icons/grapes.svg',
      width: 30,  // Set the desired width
      height: 30, // Set the desired height
      color: Colors.white, // Optionally set a color
    ),
    6: SvgPicture.asset(
      'assets/icons/oranges.svg',
      width: 30,  // Set the desired width
      height: 30, // Set the desired height
      color: Colors.white, // Optionally set a color
    ),
  };
  final Map<int, Color> colors = {
    1: const Color(0xffF67979),
    2: const Color(0xffFFE380),
    3: const Color(0xffF3E1A3),
    4: const Color(0xffF6EA79),
    5: const Color(0xff6A4382),
    6: const Color(0xffFFB763),
  };


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colors[offer.offerTypeId],
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(5, 5), // Shadow moved to the right and bottom
                    )
                  ],
                ),
                child: Center(child: offerTypes[offer.offerTypeId]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      StarRating(
                        rating: (2*offer.avgRating).floorToDouble()/2,
                        allowHalfRating: true,
                        mainAxisAlignment: MainAxisAlignment.start,
                        size: 24,
                      ),
                      const SizedBox(width: 12,),
                      Text(offer.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.tertiary),),

                    ],
                  ),
                  Text("${offer.pricePerKG}lv/kg ") //TODO: add town to user class (update api and db)
                ],
              )

            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context){
            return OfferView(offer: offer);
          }),
        );
      },
    );
  }
}

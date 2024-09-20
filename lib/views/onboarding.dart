import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:market/components/onboarding_data.dart';
import 'package:market/views/landing.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final CarouselSliderController _carouselController = CarouselSliderController();
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 0,
                onPageChanged: (index, _) {
                  setState(() {
                    currentSlider = index;
                  });
                },
              ),
              items: data.map((e) {
                return Image.asset(e["image"], width: double.infinity, fit: BoxFit.cover,);
              }).toList(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                height: 267,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Color(0xffFEFEFE),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data[currentSlider]["title"],
                      style: const TextStyle(
                        color: Color(0xff384161),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,

                      ),
                    ),
                    const SizedBox(height: 18,),
                    Text(
                      data[currentSlider]["desc"],
                      style: const TextStyle(
                        color: Color(0xff384161),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,

                      ),
                    ),
                    const SizedBox(height: 44,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            if(currentSlider==0) return;
                            setState(() {
                              currentSlider -= 1;
                            });
                          },
                          child: const Text("Back"),
                        ),
                        TextButton(
                          onPressed: () {
                            if(currentSlider == data.length-1) {
                              Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context){
                                  return const Landing();
                                }),
                                (Route<dynamic> route) => false,
                              );
                              return;
                            }
                            setState(() {
                              currentSlider += 1;
                            });
                          },
                          child: const Text("Next"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


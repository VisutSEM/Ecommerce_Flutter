import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerSlider extends StatelessWidget {
  final List<String> banners;
  final RxInt currentIndex;

  const BannerSlider({
    super.key,
    required this.banners,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: .9,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
          items: banners.map((image) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10),

        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 8,
              width: currentIndex.value == index ? 24 : 8,
              decoration: BoxDecoration(
                color: currentIndex.value == index
                    ? Colors.blue
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
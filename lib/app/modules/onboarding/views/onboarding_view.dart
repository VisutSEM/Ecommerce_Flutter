import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    final List<Map<String, dynamic>> onboardingData = [
      {
        "image": Icons.shopping_bag,
        "title": "Welcome to Zendo",
        "description":
        "Discover the best products with easy shopping and fast delivery.",
      },
      {
        "image": Icons.payment,
        "title": "Secure Payment",
        "description":
        "Pay safely using multiple payment methods with full security.",
      },
      {
        "image": Icons.local_shipping,
        "title": "Fast Delivery",
        "description":
        "Get your orders delivered quickly to your doorstep anytime.",
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Get.offAllNamed('/login');
                },
                child: const Text("Skip"),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {

                  final item = onboardingData[index];

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                          item['image'],
                          size: 140,
                          color: Colors.blue,
                        ),

                        const SizedBox(height: 40),

                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          item['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed('/login');
                  },
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blueAccent) ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
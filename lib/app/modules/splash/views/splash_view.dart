import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_color.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.flash_on, size: 80, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Lightning',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}
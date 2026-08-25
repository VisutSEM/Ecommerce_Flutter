import 'package:e_commerce_flutter/app/core/features/auth/data/providers/api_provider.dart';
import 'package:get/get.dart';
import 'modules/splash/controllers/splash_controller.dart';
class DependencyInjection {
  void init(){
    Get.put(SplashController());
    Get.put(ApiProvider());
  }
}
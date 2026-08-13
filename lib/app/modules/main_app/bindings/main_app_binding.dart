import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../product/controllers/product_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/main_app_controller.dart';

class MainAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainAppController>(
      () => MainAppController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<ProductController>(() => ProductController());

    Get.lazyPut<CartController>(() => CartController());

    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

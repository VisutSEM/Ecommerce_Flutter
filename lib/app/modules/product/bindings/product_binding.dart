// import 'package:get/get.dart';
//
// import '../controllers/product_controller.dart';
//
// class ProductBinding extends Bindings {
//
//   @override
//   void dependencies() {
//
//     // Get.lazyPut<ProductController>(
//     //       () => ProductController(Get.find()),
//     // );
//
//     // Get.lazyPut<ProductController>(
//     //       () => ProductController(Get.find()),
//     // );
//
//   }
// }



//====================
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
          () => ProductController(),
    );
  }
}
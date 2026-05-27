import 'package:get/get.dart';

import '../../product/data/models/product_model.dart';


class ProductDetailController extends GetxController {

  late ProductModel product;

  @override
  void onInit() {
    super.onInit();

    product = Get.arguments as ProductModel;
  }
}
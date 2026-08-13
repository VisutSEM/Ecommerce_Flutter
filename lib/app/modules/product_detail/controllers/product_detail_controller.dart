import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../product/data/models/product_model.dart';


class ProductDetailController extends GetxController {

  ProductModel? product;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is ProductModel) {
      product = args;
    }
  }

  void showImagePreview(String imageUrl) {
    Get.to(
          () => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 5.0,
                  boundaryMargin: const EdgeInsets.all(80),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.white,
                        size: 60,
                      );
                    },
                  ),
                ),
              ),

              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: Get.back,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

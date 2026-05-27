import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {

    final product = controller.product;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(product.title ?? "Detail"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 350,
              width: double.infinity,

              child: Image.network(
                product.images?[0] ?? '',
                fit: BoxFit.cover,

                errorBuilder: (_, __, ___) {
                  return const Center(
                    child: Icon(Icons.broken_image, size: 80),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    product.title ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {

                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),

                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
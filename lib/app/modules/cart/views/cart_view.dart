import 'package:e_commerce_flutter/app/modules/product/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  CartView({super.key});

  final  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      /// ================= APPBAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      /// ================= BODY =================
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey,
                ),

                SizedBox(height: 20),

                Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Add some products to cart",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            /// ================= CART LIST =================
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),

                itemCount: controller.cartItems.length,

                itemBuilder: (context, index) {
                  final product =
                  controller.cartItems[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(0.05),

                          blurRadius: 10,
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        /// PRODUCT IMAGE
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(14),

                          child: Image.network(
                            product['image'],
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 14),

                        /// PRODUCT INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [
                              Text(
                                product['title'],

                                maxLines: 2,
                                overflow:
                                TextOverflow.ellipsis,

                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "\$${product['price']}",

                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// QUANTITY
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller
                                          .decreaseQty(
                                          index);
                                    },

                                    child: Container(
                                      padding:
                                      const EdgeInsets
                                          .all(6),

                                      decoration:
                                      BoxDecoration(
                                        color: Colors
                                            .grey.shade200,

                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            8),
                                      ),

                                      child: const Icon(
                                        Icons.remove,
                                        size: 18,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        12),

                                    child: Text(
                                      product['qty']
                                          .toString(),

                                      style:
                                      const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      controller
                                          .increaseQty(
                                          index);
                                    },

                                    child: Container(
                                      padding:
                                      const EdgeInsets
                                          .all(6),

                                      decoration:
                                      BoxDecoration(
                                        color: Colors.blue,

                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            8),
                                      ),

                                      child: const Icon(
                                        Icons.add,
                                        size: 18,
                                        color:
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// DELETE
                        IconButton(
                          onPressed: () {
                            controller.removeItem(
                                index);
                          },

                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// ================= BOTTOM TOTAL =================
            Container(
              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Obx(
                            () => Text(
                          "\$${controller.totalPrice.toStringAsFixed(2)}",

                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                      ),

                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
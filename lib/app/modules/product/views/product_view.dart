// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/product_controller.dart';
//
// class ProductView extends GetView<ProductController> {
//  ProductView({super.key});
//
//   @override
//   final ProductController controller = Get.put(ProductController(Get.find()));
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       drawer: Drawer(
//         child: Column(
//           children: [
//             const SizedBox(height: 100),
//
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text("Logout"),
//
//               onTap: () async {
//                 await controller.logout();
//
//                 Get.offAllNamed('/login');
//               },
//             ),
//           ],
//         ),
//       ),
//
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "Products",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//
//       body: Obx(() {
//
//         if (controller.isLoading.value) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//
//         if (controller.products.isEmpty) {
//           return const Center(
//             child: Text(
//               "No Products Found",
//               style: TextStyle(fontSize: 16),
//             ),
//           );
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.fetchProducts,
//
//           child: GridView.builder(
//             padding: const EdgeInsets.all(12),
//
//             itemCount: controller.products.length,
//
//             gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 0.68,
//             ),
//
//             itemBuilder: (context, index) {
//
//               final product = controller.products[index];
//
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(18),
//
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//
//                   children: [
//
//                     /// PRODUCT IMAGE
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(18),
//                         ),
//
//                         child: Image.network(
//                           product.images?[0] ?? '',
//
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//
//                           loadingBuilder:
//                               (context, child, loadingProgress) {
//
//                             if (loadingProgress == null) {
//                               return child;
//                             }
//
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           },
//
//                           errorBuilder: (_, __, ___) {
//                             return const Center(
//                               child: Icon(
//                                 Icons.broken_image,
//                                 size: 40,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//
//                     /// PRODUCT INFO
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//
//                       child: Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//
//                         children: [
//
//                           /// TITLE
//                           Text(
//                             product.title.toString(),
//
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//
//                           const SizedBox(height: 6),
//
//                           /// PRICE
//                           Text(
//                             "\$${product.price}",
//
//                             style: const TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//
//                           const SizedBox(height: 10),
//
//                           /// BUTTON
//                           SizedBox(
//                             width: double.infinity,
//
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // add to cart
//                               },
//
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor:
//                                 Colors.blue.shade300,
//
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                   BorderRadius.circular(12),
//                                 ),
//                               ),
//
//                               child: const Text(
//                                 "Add to Cart",
//
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//     );
//   }
// }

//============Static================

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_flutter/app/modules/home/views/home_view.dart';
import 'package:e_commerce_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  ProductView({super.key});

  @override
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      /// ================= DRAWER =================
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text("Sem Visut"),
              accountEmail: Text("visut@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Get.toNamed('/main-app');
              },
            ),

            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Cart"),
              onTap: () {
                Get.toNamed('/cart');
              },
            ),

            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Wishlist"),
              onTap: () {},
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),

      /// ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          "E-Commerce",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),

      /// ================= BODY =================
      body: RefreshIndicator(
        onRefresh: controller.refreshProfile,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 16),

              /// SEARCH
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    prefixIcon: const Icon(Icons.search),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ================= BANNER =================
              CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,

                  onPageChanged: (index, reason) {
                    controller.currentBanner.value = index;
                  },
                ),

                items: controller.banners.map((image) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              /// DOT INDICATOR
              Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: List.generate(
                    controller.banners.length,
                        (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),

                        margin: const EdgeInsets.symmetric(horizontal: 4),

                        height: 8,

                        width:
                        controller.currentBanner.value == index
                            ? 24
                            : 8,

                        decoration: BoxDecoration(
                          color:
                          controller.currentBanner.value == index
                              ? Colors.blue
                              : Colors.grey.shade400,

                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ================= CATEGORIES =================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),

                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 100,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  padding:
                  const EdgeInsets.symmetric(horizontal: 12),

                  itemCount: controller.categories.length,

                  itemBuilder: (context, index) {
                    final category =
                    controller.categories[index];

                    return Container(
                      width: 80,
                      margin:
                      const EdgeInsets.symmetric(horizontal: 6),

                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(18),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.05),

                                  blurRadius: 8,
                                ),
                              ],
                            ),

                            child: Icon(
                              category['icon'],
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            category['name'],
                            style:
                            const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              /// ================= PRODUCTS =================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),

                child: Text(
                  "Popular Products",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// PRODUCT GRID
              Obx(
                    () => GridView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),

                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),

                  itemCount: controller.products.length,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.68,
                  ),

                  itemBuilder: (context, index) {
                    final product =
                    controller.products[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(0.05),

                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          /// IMAGE
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                              const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),

                              child: Image.network(
                                product['image'],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          /// INFO
                          Padding(
                            padding:
                            const EdgeInsets.all(12),

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
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  "\$${product['price']}",

                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                SizedBox(
                                  width: double.infinity,

                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.snackbar(
                                        "Success",
                                        "Added to cart",
                                        snackPosition:
                                        SnackPosition.BOTTOM,
                                      );
                                      Get.find<CartController>().addToCart(product);
                                    },

                                    style:
                                    ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.blue,

                                      elevation: 0,

                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            14),
                                      ),
                                    ),

                                    child: const Text(
                                      "Add to Cart",

                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class ProductCard extends StatelessWidget {
//   final String title;
//   final String image;
//   final double price;
//
//   const ProductCard({
//     super.key,
//     required this.title,
//     required this.image,
//     required this.price,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   image,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               "\$${price.toStringAsFixed(2)}",
//               style: const TextStyle(
//                 color: Colors.green,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:e_commerce_flutter/app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../data/models/product_model.dart';
import '../../../routes/app_pages.dart';

class ProductCard extends GetView<ProductController> {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());

    late final price = double.tryParse(product.price.toString()) ?? 0;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),

            borderRadius: BorderRadius.circular(25),

            // Glass border
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1,
            //  color: Colors.black.withOpacity(0.5)
            ),

            // Soft glass shadow
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.01),
                blurRadius: 80,
                offset: const Offset(0, 12),
              ),
             // BoxShadow(blurRadius: 1,spreadRadius:0,color: Colors.black)
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Get.toNamed(
                Routes.PRODUCT_DETAIL,
                arguments: product,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, __, ___) =>
                      const Icon(Icons.broken_image),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      Divider(),
                      const SizedBox(height: 8),

                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(child: Text(product.description,style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,)),
                            GestureDetector(
                              onTap: (){
                                controller.addToCart(product);
                                cartController.addToCart({
                                'title': product.name,
                                'image': product.image ?? '',
                                'price': price,
                                'qty': 1,
                                'id': product.id,
                                'slug': product.slug,
                                });
                              },
                              child: Container(

                                decoration: BoxDecoration(
                                  // gradient: LinearGradient(colors: [
                                  //   Colors.blue.shade900,
                                  //   Colors.red.shade600,
                                  // ]),
                                  color: Colors.green.withOpacity(0.5),
                                  boxShadow: [
                                   // BoxShadow(blurRadius: 0.5,spreadRadius: 0.1,color: Colors.black)
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(onPressed: (){
                                  cartController.addToCart({
                                    'title': product.name,
                                    'image': product.image ?? '',
                                    'price': price,
                                    'qty': 1,
                                    'id': product.id,
                                    'slug': product.slug,
                                  });
                                }, icon: Icon(Icons.add_shopping_cart_outlined),color: Colors.greenAccent,)
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
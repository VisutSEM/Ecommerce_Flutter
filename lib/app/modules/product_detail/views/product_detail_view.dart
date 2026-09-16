
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_flutter/app/core/theme/app_color.dart';
import 'package:e_commerce_flutter/app/modules/product/widgets/copy_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../product/data/models/product_model.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel? product = controller.product;

    if (product == null) {
      return Container(
        decoration: BoxDecoration(
          gradient: AppColors.gradientV3
        ),
        child: Scaffold(
          backgroundColor:  Colors.transparent,
          appBar: AppBar(
           // backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: const Center(
            child: Text(
              'No product selected',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );
    }

    final cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());

    final price = double.tryParse(product.price.toString()) ?? 0;

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradientV5
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,B
        //   iconTheme: const IconThemeData(color: Colors.black),
        //   title: const Text(
        //     'Product Detail',
        //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
          width: double.infinity,
            color: Colors.transparent,
            child: product.image.isNotEmpty
                ? GestureDetector(
              onTap: (){
                Get.dialog(
                  Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                        InteractiveViewer( minScale: 1.0,
                      maxScale: 5.0 ,child: CachedNetworkImage(imageUrl: product.image,fit: BoxFit.cover,))
                      ],
                    ),
                  )
                );
              },
                  child: CachedNetworkImage(
                                imageUrl: product.image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) {
                  debugPrint("Image URL: ${product.image}");
                  debugPrint("Error: $error");

                  return  Icon(
                    Icons.broken_image,
                    size: 110,
                    color: Colors.grey,
                  );
                                },
                              ),
                )
                :  Center(
              child:  Icon(
                Icons.image,
                size: 110,
                color: Colors.grey,
              ),),
          )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        // _InfoChip(
                        //   icon: Icons.tag_outlined,
                        //   label: 'Category ${product.categoryId}',
                        // ),
                        // _InfoChip(icon: Icons.link_outlined, label: product.slug),
                        CopyContainer(text: product.slug),
                        // _InfoChip(
                        //   icon: Icons.confirmation_number_outlined,
                        //   label: 'ID ${product.id}',
                        // ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description.isNotEmpty
                          ? product.description
                          : 'No description available.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: AppColors.gradientV7,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back,color: Colors.white,),
                              label: const Text('Back',style: TextStyle(color: Colors.white),),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black87,
                                side: BorderSide(color: Colors.transparent),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                 // borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: AppColors.gradient
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () {

                                cartController.addToCart({
                                  'title': product.name,
                                  'image': product.image,
                                  'price': price,
                                  'qty': 1,
                                  'id': product.id,
                                  'slug': product.slug,
                                });
                              },
                              icon: const Icon(Icons.shopping_cart_outlined),
                              label: const Text('Add to cart'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

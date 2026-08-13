import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_flutter/app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../../../routes/app_pages.dart';
import '../widgets/product_card.dart';

class ProductView extends GetView<ProductController> {
 const ProductView({super.key});

  @override
  Widget build(BuildContext context) {

    final cartController = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController());
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradient,
      ),
      child: Scaffold(
       // backgroundColor: const Color(0xffF6F7FB),
       backgroundColor: Colors.transparent,

        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   automaticallyImplyLeading: false,
        //   titleSpacing: 16,
        //   title: Row(
        //
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(4),
        //         child: CircleAvatar(
        //           radius: 25,
        //           backgroundColor: AppColors.border,
        //         ),
        //       ),
        //     ],
        //   ),
        //   actions: [
        //
        //     /// Favourite
        //     Obx(() =>
        //         Stack(
        //           children: [
        //             IconButton(
        //               icon: const Icon(
        //                 Icons.favorite_border,
        //                 color: Colors.black,
        //               ),
        //               onPressed: () {},
        //             ),
        //
        //             if (controller.favouriteIds.isNotEmpty)
        //               Positioned(
        //                 right: 10,
        //                 top: 10,
        //                 child: Container(
        //                   padding: const EdgeInsets.all(4),
        //                   decoration: const BoxDecoration(
        //                     color: Colors.red,
        //                     shape: BoxShape.circle,
        //                   ),
        //                   child: Text(
        //                     controller.favouriteIds.length.toString(),
        //                     style: const TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 10,
        //                     ),
        //                   ),
        //                 ),
        //               )
        //           ],
        //         )),
        //
        //     /// Cart
        //     Obx(() =>
        //         Stack(
        //           children: [
        //             IconButton(
        //               icon: const Icon(
        //                 Icons.shopping_cart_outlined,
        //                 color: Colors.black,
        //               ),
        //               onPressed: () {
        //                 Get.toNamed(Routes.CART);
        //               },
        //             ),
        //             if (cartController.cartItems.isNotEmpty)
        //               Positioned(
        //                 right: 1,
        //                 top: 1,
        //                 child: Container(
        //                   padding: const EdgeInsets.all(2),
        //                   decoration: const BoxDecoration(
        //                     color: Colors.red,
        //                     shape: BoxShape.circle,
        //                   ),
        //                   child: Text(
        //                     cartController.cartItems.length.toString(),
        //                     style: const TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 10,
        //                     ),
        //                   ),
        //                 ),
        //               )
        //           ],
        //         )),
        //   ],
        // ),

        body: RefreshIndicator(
          onRefresh: () async{
            await controller.fetchProducts();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(30),
                        child: Container(
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(60)
                          ),
                          child: Image.asset('assets/images/psg_logo.jpg'),
                        ),
                      )
                    ),
                    Row(
                      children: [
                        /// Favourite
                        Obx(() =>
                            Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),

                                if (controller.favouriteIds.isNotEmpty)
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        controller.favouriteIds.length.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            )),
                        Obx(() =>
                            Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Get.toNamed(Routes.CART);
                                  },
                                ),
                                if (cartController.cartItems.isNotEmpty)
                                  Positioned(
                                    right: 1,
                                    top: 1,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        cartController.cartItems.length.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                /// Search
                Obx(
                      () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: controller.searchProduct,
                      decoration: InputDecoration(
                        hintText: "Search products...",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: controller.isSearching.value
                            ? const Padding(
                          padding: EdgeInsets.all(14),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                            : null,
                        filled: true,
                        fillColor: Colors.white54,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Banner
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: .9,
                    onPageChanged: (index, reason) {
                      controller.currentBanner.value = index;
                    },
                  ),
                  items: controller.banners.map((banner) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        image: DecorationImage(
                          image: NetworkImage(banner),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                Center(
                  child: Obx(() =>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.banners.length,
                              (index) =>
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                height: 8,
                                width: controller.currentBanner.value == index
                                    ? 24
                                    : 8,
                                decoration: BoxDecoration(
                                  color: controller.currentBanner.value == index
                                      ? Colors.blue
                                      : Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                        ),
                      )),
                ),

                const SizedBox(height: 24),

                /// Categories
                Obx(
                        () {
                      if(controller.isLoading.value){
                        return  Center(child: CircularProgressIndicator(color: Colors.transparent,));
                      }
                      else{
                        null;
                      }
                      return  Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Popular Products",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      );
                    }
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 50,
                  child: Obx(
                        () {
                          final isSelected = controller.selectedCategory.value == 0;
                          if(controller.isLoading.value){
                            return Center(child: CircularProgressIndicator(color: Colors.transparent,));
                          }
                          return Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? LinearGradient(
                                    colors: [
                                      Colors.blue.shade900,
                                      Colors.red.shade600,
                                    ],
                                  )
                                      : null,
                                  color: isSelected
                                      ? null
                                      : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.transparent
                                        : Colors.grey,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isSelected
                                          ? Colors.black.withValues(alpha: 0.25)
                                          : Colors.black.withValues(alpha: 0.05),
                                      blurRadius: isSelected ? 12 : 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isSelected) ...[
                                      const Icon(
                                        Icons.check_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    Text(
                                      'All',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: controller.categories.length,
                                itemBuilder: (context, index) {
                                  final category = controller.categories[index];

                                  // Make sure both IDs are int
                                  final categoryId = int.parse(
                                    category['id'].toString(),
                                  );

                                  return Obx((){
                                    final selected =
                                        controller.selectedCategory.value == categoryId;
                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectCategory(categoryId);
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        margin: const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: selected
                                              ? LinearGradient(
                                            colors: [
                                              Colors.blue.shade900,
                                              Colors.red.shade600,
                                            ],
                                          )
                                              : null,
                                          color: selected
                                              ? null
                                              : Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: selected
                                                ? Colors.transparent
                                                : Colors.grey,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: selected
                                                  ? Colors.black.withValues(alpha: 0.25)
                                                  : Colors.black.withValues(alpha: 0.05),
                                              blurRadius: selected ? 12 : 6,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (selected) ...[
                                              const Icon(
                                                Icons.check_rounded,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 6),
                                            ],
                                            Text(
                                              category['name'] ?? '',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: selected
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              ),
                            ],
                          );
                        }
                  )
                ),

                const SizedBox(height: 25),

                Obx(
                   () {
                     if(controller.isLoading.value){
                       return  Center(child: CircularProgressIndicator(color: Colors.transparent,));
                     }
                     else{
                       null;
                     }
                    return  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Popular Products",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    );
                  }
                ),

                const SizedBox(height: 16),

                /// Product Grid
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator(color: Colors.white,),
                      ),
                    );
                  }

                  if (controller.filteredProducts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          "មិនទាន់មាន ទំនិញនៅឡើយទេ",
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                      ),
                    );
                  }
                  if (controller.isSearching.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white,),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.filteredProducts.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: .65,
                    ),
                    itemBuilder: (context, index) {
                      final product =
                      controller.filteredProducts[index];

                      return ProductCard(product: product);
                    },
                  );
                }),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
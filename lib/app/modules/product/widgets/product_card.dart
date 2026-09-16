import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../cart/controllers/cart_controller.dart';
import '../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Material(
      color: Colors.white.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        splashColor: Colors.white.withValues(alpha: 0.08),
        highlightColor: Colors.white.withValues(alpha: 0.04),
        onTap: () {
          Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─────────────────────────────────────────────
              // PRODUCT IMAGE
              // ─────────────────────────────────────────────
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.85,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Container(
                          color: Colors.white.withValues(alpha: 0.06),
                          alignment: Alignment.center,
                          child: const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white54,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          color: Colors.white.withValues(alpha: 0.06),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.white38,
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: (){},
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.28),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                          ),
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // ─────────────────────────────────────────────
              // PRODUCT DETAILS
              // ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Price + Cart
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Modern Cart Button
                        _AddToCartButton(
                          onPressed: () {
                            cart.addToCart({
                              'title': product.name,
                              'image': product.image,
                              'price': product.price,
                              'qty': 1,
                              'id': product.id,
                              'slug': product.slug,
                            });

                            Get.snackbar(
                              'Added to cart',
                              product.name,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(16),
                              borderRadius: 14,
                              backgroundColor: Colors.black.withValues(
                                alpha: 0.85,
                              ),
                              colorText: Colors.white,
                              duration: const Duration(seconds: 1),
                              icon: const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.greenAccent,
                              ),
                            );
                          },
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

// ─────────────────────────────────────────────────────────────
// MODERN ADD TO CART BUTTON
// ─────────────────────────────────────────────────────────────

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(13),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Center(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                  size: 21,
                ),
              ),

              // Small + badge
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white, size: 11),
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

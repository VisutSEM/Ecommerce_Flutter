// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../core/features/auth/data/providers/api_provider.dart';
// import '../data/models/product_model.dart';
//
// class ProductController extends GetxController {
//
//   final ApiProvider _provider = Get.find<ApiProvider>();
//   final ApiProvider provider;
//
//
//   ProductController(this.provider);
//
//   RxBool isLoading = false.obs;
//
//   RxList<ProductModel> products = <ProductModel>[].obs;
//
//   @override
//   void onInit() {
//     fetchProducts();
//     super.onInit();
//   }
//
//   Future<void> fetchProducts() async {
//
//     try {
//
//       isLoading(true);
//
//
//       final response = await _provider.fetchProduct();
//
//       if (response.statusCode == 200) {
//
//         final List data = response.data;
//
//         products.assignAll(
//           data.map((e) => ProductModel.fromJson(e)).toList(),
//         );
//
//       } else {
//
//         Get.snackbar(
//           "Error",
//           "Failed to fetch products",
//         );
//
//       }
//
//     } catch (e) {
//
//       Get.snackbar(
//         "Error",
//         e.toString(),
//       );
//
//     } finally {
//
//       isLoading(false);
//
//     }
//   }
//
//   Future<void> refreshProducts() async {
//     await fetchProducts();
//   }
//
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.clear();
//   }
// }


//=============== TEST ==================

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

/// ================= CONTROLLER =================
class ProductController extends GetxController {
  RxInt currentBanner = 0.obs;

  final List<String> banners = [
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
    'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
  ];

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.phone_android, 'name': 'Phones'},
    {'icon': Icons.laptop_mac, 'name': 'Laptop'},
    {'icon': Icons.watch, 'name': 'Watch'},
    {'icon': Icons.headphones, 'name': 'Audio'},
    {'icon': Icons.sports_basketball, 'name': 'Sports'},
    {'icon': Icons.chair, 'name': 'Furniture'},
  ];

  final RxList<Map<String, dynamic>> products =
      <Map<String, dynamic>>[
        {
          'title': 'iPhone 15 Pro',
          'price': 1299,
          'image':
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569',
        },
        {
          'title': 'Nike Air Max',
          'price': 220,
          'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
        },
        {
          'title': 'Apple Watch',
          'price': 499,
          'image':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
        },
        {
          'title': 'Gaming Headphone',
          'price': 150,
          'image':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
        },
        {
          'title': 'Modern Chair',
          'price': 320,
          'image':
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85',
        },
        {
          'title': 'MacBook Pro',
          'price': 2499,
          'image':
          'https://cdn.mos.cms.futurecdn.net/CdjUeQhrbWmiaggGQMycQh.jpg',
        },
      ].obs;

  Future<void> refreshProfile() async {
    await loadProfile();
  }

  Future<void> loadProfile() async {}
}
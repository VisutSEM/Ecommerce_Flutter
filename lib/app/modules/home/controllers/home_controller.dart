// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../core/features/auth/data/providers/api_provider.dart';
// import '../../product/data/models/product_model.dart';
//
// class HomeController extends GetxController {
//   RxString name = ''.obs;
//   RxString email = ''.obs;
//   RxBool isLoading = RxBool(true);
//
//   final ApiProvider _provider = Get.find<ApiProvider>();
//
//   //ProductController(this.provider);
//   RxList<ProductModel> products = <ProductModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getCurrentUser();
//   }
//
//   Future<void> getCurrentUser() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final userData = prefs.getString('user');
//
//     if (userData != null) {
//       final user = jsonDecode(userData);
//
//       name.value = user['name'] ?? '';
//       email.value = user['email'] ?? '';
//     }
//   }
//
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     await prefs.clear();
//   }
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
// }

//=====================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class HomeController extends GetxController {
//   /// ================= USER =================
//   RxString userName = "Sem Visut".obs;
//
//   RxString userEmail =
//       "visut@gmail.com".obs;
//
//   RxString userImage =
//       "https://i.pravatar.cc/300".obs;
//
//   /// ================= EVENT BANNERS =================
//   final List<Map<String, dynamic>> banners = [
//     {
//       "title": "Summer Sale",
//       "subtitle": "Up to 50% OFF",
//       "image":
//       "https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da",
//       "color": 0xFF6C63FF,
//     },
//     {
//       "title": "Mega Discount",
//       "subtitle": "Buy 1 Get 1",
//       "image":
//       "https://images.unsplash.com/photo-1607083206968-13611e3d76db",
//       "color": 0xFFFF6584,
//     },
//     {
//       "title": "Flash Sale",
//       "subtitle": "Today Only",
//       "image":
//       "https://images.unsplash.com/photo-1483985988355-763728e1935b",
//       "color": 0xFF00BFA6,
//     },
//   ];
//
//   /// ================= CATEGORIES =================
//   final List<Map<String, dynamic>> categories = [
//     {
//       "icon": "📱",
//       "title": "Phones",
//     },
//     {
//       "icon": "💻",
//       "title": "Laptop",
//     },
//     {
//       "icon": "⌚",
//       "title": "Watch",
//     },
//     {
//       "icon": "🎧",
//       "title": "Audio",
//     },
//     {
//       "icon": "👟",
//       "title": "Shoes",
//     },
//     {
//       "icon": "🪑",
//       "title": "Furniture",
//     },
//   ];
// }


import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/features/auth/data/providers/api_provider.dart';

class HomeController extends GetxController {

  /// ================= USER =================
  RxString userName = ''.obs;

  RxString userEmail = ''.obs;

  RxString userImage = ''.obs;

  /// ================= SELECTED CATEGORY =================
  RxInt selectedCategory = 0.obs;

  /// ================= EVENT BANNERS =================
  final List<Map<String, dynamic>> banners = [
    {
      "title": "Summer Sale",
      "subtitle": "Up to 50% OFF",
      "image":
      "https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da",
      "color": 0xFF6C63FF,
    },
    {
      "title": "Mega Discount",
      "subtitle": "Buy 1 Get 1",
      "image":
      "https://images.unsplash.com/photo-1607083206968-13611e3d76db",
      "color": 0xFFFF6584,
    },
    {
      "title": "Flash Sale",
      "subtitle": "Today Only",
      "image":
      "https://images.unsplash.com/photo-1483985988355-763728e1935b",
      "color": 0xFF00BFA6,
    },
  ];

  /// ================= CATEGORIES =================
  // final List<Map<String, dynamic>> categories = [
  //   {
  //     "title": "All",
  //     "icon": "🛍️",
  //     "color": 0xFF6C63FF,
  //   },
  //   {
  //     "title": "Phones",
  //     "icon": "📱",
  //     "color": 0xFF4CAF50,
  //   },
  //   {
  //     "title": "Laptop",
  //     "icon": "💻",
  //     "color": 0xFFFF9800,
  //   },
  //   {
  //     "title": "Watch",
  //     "icon": "⌚",
  //     "color": 0xFFE91E63,
  //   },
  //   {
  //     "title": "Audio",
  //     "icon": "🎧",
  //     "color": 0xFF03A9F4,
  //   },
  //   {
  //     "title": "Shoes",
  //     "icon": "👟",
  //     "color": 0xFFFF5722,
  //   },
  //   {
  //     "title": "Furniture",
  //     "icon": "🪑",
  //     "color": 0xFF795548,
  //   },
  //   {
  //     "title": "Gaming",
  //     "icon": "🎮",
  //     "color": 0xFF9C27B0,
  //   },
  //   {
  //     "title": "Camera",
  //     "icon": "📷",
  //     "color": 0xFF009688,
  //   },
  //   {
  //     "title": "Fashion",
  //     "icon": "👕",
  //     "color": 0xFFFF4081,
  //   },
  // ];

  final ApiProvider _provider = Get.find<ApiProvider>();
  RxBool isLoading = false.obs;
  final categories = [].obs;
  /// ================= LOAD USER =================
  @override
  void onInit() {
    super.onInit();
    getCategories();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs =
    await SharedPreferences.getInstance();

    userName.value =
        prefs.getString('name') ?? 'Guest';

    userEmail.value =
        prefs.getString('email') ?? '';

    userImage.value =
        prefs.getString('image') ?? '';
  }

  /// ================= CHANGE CATEGORY =================
  void changeCategory(int index) {
    selectedCategory.value = index;
  }

  // ========== Category ==========

  //final RxList categories = [].obs;
  final RxBool isLoadingCategories = false.obs;

// ========== Category ==========
  Future<void> getCategories() async {
    isLoading.value = true;

    try {
      final response = await _provider.getCate();

      print(response.data); // Check API response

      if (response.statusCode == 200) {
        categories.assignAll(response.data['data'] ?? []);
      }
    } catch (e) {
      debugPrint('Error loading categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  }
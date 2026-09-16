


//=============== TEST =================

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/features/auth/data/providers/api_provider.dart';
import '../data/models/product_model.dart';

/// ================= CONTROLLER =================
class ProductController extends GetxController {
  final ApiProvider _provider = Get.find<ApiProvider>();
  RxBool isLoading = false.obs;
  RxInt currentBanner = 0.obs;
  final isSearching = false.obs;

  /// Search
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  /// Favourite
  final RxList<int> favouriteIds = <int>[].obs;

  /// Cart
  final RxList<ProductModel> cart = <ProductModel>[].obs;

  /// Selected Category
  final RxInt selectedCategory = 0.obs;

  ProductModel? product;
  @override
  void onInit() {
    // TODO: implement onInit
    fetchProducts();
    getCategories();
    selectedCategory();
    super.onInit();
    final args = Get.arguments;
    if (args is ProductModel) {
      product = args;
    }
  }


  final List<String> banners = [
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
    'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
  ];

  final categories =[].obs;
  final products = <ProductModel>[].obs;




  void toggleFavourite(ProductModel product) {
    if (favouriteIds.contains(product.id)) {
      favouriteIds.remove(product.id);
    } else {
      favouriteIds.add(product.id);
    }
  }

  Future<void> addToCart(ProductModel product) async {
    // Prevent duplicate products (optional)
    if (cart.any((item) => item.id == product.id)) {
      // Get.snackbar(
      //   "Already Added",
      //   "${product.name} is already in your cart.",
      //   snackPosition: SnackPosition.TOP,
      // );
      return;
    }

    // Add product to cart
    cart.add(product);

    // Save cart to SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    final cartJson = cart.map((item) => item.toJson()).toList();
    await prefs.setString("cart", jsonEncode(cartJson));

  }
  void selectCategory(int id) async{

    // Update UI immediately
    selectedCategory.value = id;

    final allCate = 0.obs;
    if (id == 0) {
      // Show all products
      filteredProducts.assignAll(products);
      return;
    }

    // Show products from selected category
    filteredProducts.assignAll(
      products.where((product) => product.categoryId == id),
    );
    // Then load/filter products
    //  await getProductsByCategory(id);

    if (id == 0) {
      filteredProducts.assignAll(products);
      return;
    }

    filteredProducts.assignAll(
      products.where((e) => e.categoryId == id),
    );
  }


  Future<void> refreshProfile() async {
    await loadProfile();
  }

  Future<void> loadProfile() async {}

  // ========== Category ==========
  Future<void> getCategories() async {
    isLoading.value = true;

    try {
      final response = await _provider.getCate();

      if (response.statusCode == 200) {
        final data = response.data;
        final List items = data is Map<String, dynamic>
            ? (data['data'] as List? ?? [])
            : (data as List? ?? []);

        categories.assignAll(items);
      }
    } catch (e) {
      debugPrint('Error loading categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final response = await _provider.fetchProduct();

      final data = response.data;

      await Future.delayed(const Duration(milliseconds: 500));


      /// Categories
      categories.assignAll(
        List<Map<String, dynamic>>.from(data["categories"]),
      );

      /// Clear old products
      products.clear();

      /// Merge all category products into one list
      for (final category in data["categories"]) {
        final List list = category["products"] ?? [];

        products.addAll(
          list.map((e) => ProductModel.fromJson(e)).toList(),
        );
      }

      filteredProducts.assignAll(products);
      applyCategoryFilter();
      getCategories();
    } catch (e) {
      showErrorSnackbar('$e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Search
  Future<void> searchProduct(String keyword) async {
    final query = keyword.trim().toLowerCase();

    isSearching.value = true;

    try {
      // Simulate async work / API / database search
      await Future.delayed(const Duration(seconds: 1));

      if (query.isEmpty) {
        filteredProducts.assignAll(products);
        return;
      }

      final results = products.where(
            (product) =>
        product.name.toLowerCase().contains(query) ||
            product.slug.toLowerCase().contains(query),
      );

      filteredProducts.assignAll(results);
    } finally {
      isSearching.value = false;
    }
  }


  // showErrorSnackbar
  void showErrorSnackbar(String message) {
    Get.snackbar(
      'អត់បើក Server ផងមិចចេញ',
      message,
      icon: const Icon(
        Icons.error_outline_rounded,
        color: Colors.white,
        size: 28,
      ),
      backgroundColor: const Color(0xFFE53935),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  //applyCategoryFilter
  void applyCategoryFilter() {
    final categoryId = selectedCategory.value;

    if (categoryId == 0) {
      filteredProducts.assignAll(products);
      return;
    }

    filteredProducts.assignAll(
      products.where(
            (product) => product.categoryId == categoryId,
      ),
    );
  }
 }
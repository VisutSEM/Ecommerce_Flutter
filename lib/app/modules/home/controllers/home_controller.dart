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

import 'package:e_commerce_flutter/app/modules/profile/data/user.model.dart';
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
import '../../product/data/models/product_model.dart';

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
      "image": "https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da",
      "color": 0xFF6C63FF,
    },
    {
      "title": "Mega Discount",
      "subtitle": "Buy 1 Get 1",
      "image": "https://images.unsplash.com/photo-1607083206968-13611e3d76db",
      "color": 0xFFFF6584,
    },
    {
      "title": "Flash Sale",
      "subtitle": "Today Only",
      "image": "https://images.unsplash.com/photo-1483985988355-763728e1935b",
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

  final ApiProvider apiProvider = Get.find<ApiProvider>();
  final user = Rxn<UserModel>();
  RxBool isLoading = false.obs;
  final categories = [].obs;
  final products = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  /// ================= LOAD USER =================
  @override
  void onInit() {
    super.onInit();
    getCategories();
    loadUser();
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning 🌅";
    } else if (hour < 17) {
      return "Good Afternoon ☀️";
    } else if (hour < 21) {
      return "Good Evening 🌇";
    } else {
      return "Good Night 🌙";
    }
  }

  Future<void> loadProfile() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final response = await apiProvider.getUser();

      debugPrint('PROFILE STATUS: ${response.statusCode}');
      debugPrint('PROFILE RESPONSE: ${response.data}');

      if (response.statusCode == 200) {
        final profile = _parseUser(response.data);

        if (profile != null) {
          user.value = profile;
          await _saveProfile(profile);

          debugPrint('PROFILE PICTURE: ${profile.profilePicture}');

          return;
        }
      }

      await _loadCachedProfile();
    } catch (e, stackTrace) {
      debugPrint('PROFILE ERROR: $e');
      debugPrint('PROFILE STACK: $stackTrace');

      await _loadCachedProfile();

      // _showError('Profile Error', 'Unable to load your profile.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadCachedProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final name = prefs.getString('name');
      final email = prefs.getString('email');
      final phone = prefs.getString('phone');
      final avatar = prefs.getString('avatar');

      debugPrint(
        'CACHED PROFILE: '
        'name=$name, '
        'email=$email, '
        'phone=$phone, '
        'avatar=$avatar',
      );

      if (name == null && email == null && phone == null && avatar == null) {
        return;
      }

      user.value = UserModel(
        id: 0,
        name: name ?? 'Unknown User',
        email: email ?? '',
        phone: phone,
        emailVerifiedAt: null,
        profilePicture: avatar,
        createdAt: null,
        updatedAt: null,
      );
    } catch (e, stackTrace) {
      debugPrint('LOAD CACHE ERROR: $e');
      debugPrint('LOAD CACHE STACK: $stackTrace');
    }
  }

  Future<void> _saveProfile(UserModel profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('name', profile.name);
      await prefs.setString('email', profile.email);

      if (profile.phone != null && profile.phone!.isNotEmpty) {
        await prefs.setString('phone', profile.phone!);
      } else {
        await prefs.remove('phone');
      }

      // IMPORTANT:
      // Only update avatar when API gives a valid URL.
      if (profile.profilePicture != null &&
          profile.profilePicture!.trim().isNotEmpty) {
        await prefs.setString('avatar', profile.profilePicture!);

        debugPrint('AVATAR CACHE UPDATED: ${profile.profilePicture}');
      } else {
        // DON'T remove the existing cached avatar.
        debugPrint(
          'API profile_picture is null/empty. '
          'Keeping existing cached avatar.',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('SAVE PROFILE ERROR: $e');
      debugPrint('SAVE PROFILE STACK: $stackTrace');
    }
  }

  void selectCategory(int id) async {
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

    filteredProducts.assignAll(products.where((e) => e.categoryId == id));
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    userName.value = prefs.getString('name') ?? 'Guest';

    userEmail.value = prefs.getString('email') ?? '';

    userImage.value = prefs.getString('image') ?? '';
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
      final response = await apiProvider.getCate();

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

  void applyCategoryFilter() {
    final categoryId = selectedCategory.value;

    if (categoryId == 0) {
      filteredProducts.assignAll(products);
      return;
    }

    filteredProducts.assignAll(
      products.where((product) => product.categoryId == categoryId),
    );
  }

  UserModel? _parseUser(dynamic responseData) {
    try {
      if (responseData is! Map<String, dynamic>) {
        debugPrint('Invalid response type: ${responseData.runtimeType}');
        return null;
      }

      final data = responseData['data'];

      debugPrint('PROFILE DATA: $data');
      debugPrint('DATA TYPE: ${data.runtimeType}');

      Map<String, dynamic>? userData;

      // API returns:
      // "data": [...]
      if (data is List && data.isNotEmpty) {
        if (data.first is Map) {
          userData = Map<String, dynamic>.from(data.first);
        }
      }

      // Also support:
      // "data": {...}
      if (data is Map) {
        userData = Map<String, dynamic>.from(data);
      }

      if (userData == null) {
        debugPrint('No valid user data found.');
        return null;
      }

      debugPrint('RAW PROFILE PICTURE: ${userData['profile_picture']}');

      final profile = UserModel.fromJson(userData);

      debugPrint('MODEL PROFILE PICTURE: ${profile.profilePicture}');

      return profile;
    } catch (e, stackTrace) {
      debugPrint('PARSE PROFILE ERROR: $e');
      debugPrint('PARSE PROFILE STACK: $stackTrace');

      return null;
    }
  }

  Future<void> refreshProfiles() async {
    await loadProfile();
  }
}

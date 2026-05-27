import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxList<Map<String, dynamic>> cartItems =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadCart();

    ever(cartItems, (_) {
      saveCart();
    });
  }

  /// ================= SAVE CART =================
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    final String encodedData =
    jsonEncode(cartItems);

    await prefs.setString('cart_items', encodedData);
  }

  /// ================= LOAD CART =================
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final String? data =
    prefs.getString('cart_items');

    if (data != null) {
      final List decodedData =
      jsonDecode(data);

      cartItems.value =
          decodedData
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
    }
  }

  /// ================= TOTAL PRICE =================
  double get totalPrice {
    double total = 0;

    for (var item in cartItems) {
      total += item['price'] * item['qty'];
    }

    return total;
  }

  /// ================= ADD TO CART =================
  void addToCart(Map<String, dynamic> product) {
    int existingIndex = cartItems.indexWhere(
          (item) => item['title'] == product['title'],
    );

    if (existingIndex != -1) {
      cartItems[existingIndex]['qty']++;
      cartItems.refresh();
    } else {
      cartItems.add({
        ...product,
        'qty': 1,
      });
    }

    Get.snackbar(
      "Success",
      "Added to cart",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// ================= REMOVE ITEM =================
  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  /// ================= INCREASE QTY =================
  void increaseQty(int index) {
    cartItems[index]['qty']++;
    cartItems.refresh();
  }

  /// ================= DECREASE QTY =================
  void decreaseQty(int index) {
    if (cartItems[index]['qty'] > 1) {
      cartItems[index]['qty']--;
      cartItems.refresh();
    }
  }

  /// ================= CLEAR CART =================
  Future<void> clearCart() async {
    cartItems.clear();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart_items');
  }
}
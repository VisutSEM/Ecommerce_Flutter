import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxString name = ''.obs;
  RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    final userData = prefs.getString('user');

    if (userData != null) {
      final user = jsonDecode(userData);

      name.value = user['name'] ?? '';
      email.value = user['email'] ?? '';
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
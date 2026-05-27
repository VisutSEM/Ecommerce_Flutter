import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {

  final isLoading = false.obs;

  final userName = ''.obs;
  final role = ''.obs;
  final email = ''.obs;
  final avatarUrl = ''.obs;

  Future<void> loadProfile() async {

    try {

      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();

      userName.value =
          prefs.getString('name') ?? 'Unknown User';

      email.value =
          prefs.getString('email') ?? '';

      // Static role for now
      role.value = "Premium Member";

      // Optional avatar
      avatarUrl.value =
          prefs.getString('avatar') ?? '';

    } catch (e) {

      Get.snackbar(
        "Error",
        e.toString(),
      );

    } finally {

      isLoading.value = false;

    }
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }

  Future<void> logout() async {

    try {

      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();

      // Clear all saved data
      await prefs.clear();

      Get.offAllNamed(Routes.LOGIN);

    } catch (e) {

      Get.snackbar(
        "Error",
        "Logout failed",
      );

    } finally {

      isLoading.value = false;

    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }
}
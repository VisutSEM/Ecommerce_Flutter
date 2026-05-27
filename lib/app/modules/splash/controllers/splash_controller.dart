import 'package:get/get.dart';

import '../../../core/storage/token_storage.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _goNext();
  }

  Future<void> _goNext() async {

    print("Splash started");

    await Future.delayed(const Duration(seconds: 2));

    final token = await TokenStorage.getToken();

    print("Token: $token");

    if (token != null && token.isNotEmpty) {

      print("User already logged in");

      Get.offAllNamed(Routes.MAIN_APP);

    } else {

      print("User not logged in");

      //Get.offAllNamed(Routes.ONBOARDING);
      Get.offAllNamed(Routes.LOGIN);
      // or Routes.LOGIN
    }
  }
}
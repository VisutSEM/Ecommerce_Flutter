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
    await Future.delayed(const Duration(seconds: 4));

    final token = await TokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.ONBOARDING);
    }
    print("Splash started");
    print("Going next");
  }
}
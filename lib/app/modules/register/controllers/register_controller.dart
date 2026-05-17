import 'package:e_commerce_flutter/app/core/features/auth/data/models/req/register.model.dart';
import 'package:e_commerce_flutter/app/core/features/auth/data/providers/api_provider.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final _provider = Get.find<ApiProvider>();

  RxBool isLoading = false.obs;

  Future<void> register(RegisterReq req) async {
    try {
      isLoading(true);

      final response = await _provider.register(req.toJson());

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        Get.snackbar(
          "Success",
          "Register Successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.back(result: true);
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Alert",
        middleText: e.toString(),
      );
    } finally {
      isLoading(false);
    }
  }
}
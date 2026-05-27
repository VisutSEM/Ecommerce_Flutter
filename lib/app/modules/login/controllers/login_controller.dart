// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:e_commerce_flutter/app/core/storage/token_storage.dart';
//
// import '../../../core/features/auth/data/models/req/login_req.model.dart';
// import '../../../core/features/auth/data/providers/api_provider.dart';
//
// class LoginController extends GetxController {
//   final _provider = Get.find<ApiProvider>();
//
//   RxBool isLoading = false.obs;
//
//   Future<bool> login(LoginReq req) async {
//     try {
//       isLoading(true);
//
//       final response = await _provider.login(req.toJson());
//
//       // SUCCESS
//       if (response.statusCode == 200) {
//         final token = response.data['token'];
//         await TokenStorage.saveToken(token);
//
//         return true;
//       }
//
//       // WRONG EMAIL / PASSWORD (common backend case)
//       if (response.statusCode == 401 || response.statusCode == 400) {
//         _showError(
//           response.data['message'] ?? "Invalid email or password",
//         );
//         return false;
//       }
//
//       // OTHER ERRORS
//       _showError("Something went wrong. Please try again.");
//       return false;
//     } catch (e) {
//       _showError(e.toString());
//       return false;
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   void _showError(String message) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Icons.error_outline,
//                 color: Colors.red,
//                 size: 60,
//               ),
//               const SizedBox(height: 12),
//
//               const Text(
//                 "Login Failed",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () => Get.back(),
//                   child: const Text("OK",style: TextStyle(color: Colors.white),),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/token_storage.dart';
import '../../../core/features/auth/data/models/req/login_req.model.dart';
import '../../../core/features/auth/data/providers/api_provider.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {

  final _provider = Get.find<ApiProvider>();

  RxBool isLoading = false.obs;

  Future<bool> login(LoginReq req) async {

    try {

      isLoading(true);

      final response = await _provider.login(req.toJson());

      // SUCCESS
      if (response.statusCode == 200) {

        final token = response.data['token'];

        // Save token
        await TokenStorage.saveToken(token);

        // Save user info
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(
          'name',
          response.data['data']['name'] ?? '',
        );

        await prefs.setString(
          'email',
          response.data['data']['email'] ?? '',
        );

        // Optional
        await prefs.setInt(
          'user_id',
          response.data['data']['id'] ?? 0,
        );

        // Navigate
        Get.offAllNamed(Routes.MAIN_APP);

        return true;
      }

      // WRONG EMAIL / PASSWORD
      if (response.statusCode == 401 ||
          response.statusCode == 400) {

        _showError(
          response.data['message'] ??
              "Invalid email or password",
        );

        return false;
      }

      // OTHER ERRORS
      _showError(
        "Something went wrong. Please try again.",
      );

      return false;

    } catch (e) {

      _showError(e.toString());

      return false;

    } finally {

      isLoading(false);

    }
  }

  void _showError(String message) {

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),

              const SizedBox(height: 12),

              const Text(
                "Login Failed",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
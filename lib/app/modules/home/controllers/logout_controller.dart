// import 'package:get/get.dart';
//
// import '../../../core/features/auth/data/providers/api_provider.dart';
//
// class LogoutController extends GetxController{
//
//   final _provider = Get.find<ApiProvider>();
//   RxBool isLoading = RxBool(false);
//   Future<void> logout() async {
//     try {
//       isLoading(true);
//
//       final response = await _provider.logout();
//
//       if (response.statusCode == 200) {
//
//         Get.snackbar(
//           "Success",
//           "Logout Successfully",
//           snackPosition: SnackPosition.BOTTOM,
//         );
//
//         Get.offAllNamed('/login');
//       }
//
//     } catch (e) {
//
//       Get.defaultDialog(
//         title: "Error",
//         middleText: e.toString(),
//       );
//
//     } finally {
//       isLoading(false);
//     }
//   }
// }
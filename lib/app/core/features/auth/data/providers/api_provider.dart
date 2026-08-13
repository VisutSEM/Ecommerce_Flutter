import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:e_commerce_flutter/app/core/constants/app_constants.dart';
import 'package:e_commerce_flutter/app/core/storage/token_storage.dart';
class ApiProvider extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    // TODO: implement onInit
    _initializeDio();
    super.onInit();
  }

  void _initializeDio(){
      _dio = Dio(
        BaseOptions(
          // baseUrl: "${AppConstants.kBaseUrl}/api/v1",
          baseUrl: "${AppConstants.kBaseUrl}/api",
          followRedirects: false,
          validateStatus: (status){
            return status! < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          }
        )
      );
  }

  Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post(
      "/login",
      data: data,
    );
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post(
      "/register",
      data: data,
    );
  }
  Future<Response> logout() async {
    return await _dio.post("/logout");
  }

  Future<Response> getUser() async {
    return await _dio.get("/users");
  }

  Future<Response> fetchProduct() async {
    return await _dio.get(
      "/admin/products",
      options: await _authorizedOptions(),
    );
  }

  Future<Response> getCate() async {
    return await _dio.get(
      '/admin/categories',
      options: await _authorizedOptions(),
    );
  }

  Future<Options> _authorizedOptions() async {
    final token = await TokenStorage.getToken();

    return Options(
      headers: {
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );
  }

}

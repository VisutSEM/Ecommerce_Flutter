import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:e_commerce_flutter/app/core/constants/app_constants.dart';
import 'package:e_commerce_flutter/app/core/storage/token_storage.dart';

class ApiProvider extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "${AppConstants.kBaseUrl}/api",
        followRedirects: false,
        validateStatus: (status) {
          return status != null && status < 500;
        },
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> login(Map<String, dynamic> data) async {
    return await _dio.post("/login", data: data);
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return await _dio.post("/register", data: data);
  }

  Future<Response> logout() async {
    return await _dio.post("/logout", options: await _authorizedOptions());
  }

  Future<Response> getUser() async {
    return await _dio.get("/profile", options: await _authorizedOptions());
  }

  Future<Response> fetchProduct() async {
    return await _dio.get(
      "/admin/products",
      options: await _authorizedOptions(),
    );
  }

  Future<Response> getCate() async {
    return await _dio.get(
      "/admin/categories",
      options: await _authorizedOptions(),
    );
  }

  Future<Response> getProfile(Map<String, dynamic> data) async {
    return await _dio.get(
      "/users",
      queryParameters: data,
      options: await _authorizedOptions(),
    );
  }

  Future<Options> _authorizedOptions() async {
    final token = await TokenStorage.getToken();

    print("API TOKEN: $token");

    return Options(
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
      },
    );
  }

  Future<Response> updateProfilePicture(File imageFile) async {
    final token = await TokenStorage.getToken();

    print('TOKEN EXISTS: ${token != null}');
    print('TOKEN LENGTH: ${token?.length ?? 0}');

    final formData = FormData.fromMap({
      'profile_picture': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    final response = await _dio.post(
      '/profile/picture',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    print('UPLOAD STATUS: ${response.statusCode}');
    print('UPLOAD RESPONSE: ${response.data}');

    return response;
  }
}

import 'package:e_commerce_flutter/app/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/storage/token_storage.dart';
import 'app/routes/app_pages.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection().init();
  //final token = await TokenStorage.getToken();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      //initialRoute: token != null ? '/main-app' : '/onboarding',
      initialRoute:  AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

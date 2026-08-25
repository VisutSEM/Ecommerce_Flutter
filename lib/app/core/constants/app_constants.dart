import 'package:flutter/foundation.dart';

class AppConstants {
  static const String appName = "Auth App";

  static String get kBaseUrl {
    if (kIsWeb) {
      return "https://laravel-blog-api-s7od.onrender.com";
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return "https://laravel-blog-api-s7od.onrender.com";
      case TargetPlatform.linux:
        return "https://laravel-blog-api-s7od.onrender.com";
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
          return "https://laravel-blog-api-s7od.onrender.com";
    }
  }

  static String get storageUrl => "$kBaseUrl/storage";
}

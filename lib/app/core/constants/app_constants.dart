import 'package:flutter/foundation.dart';

class AppConstants {
  static const String appName = "Auth App";

  static String get kBaseUrl {
    if (kIsWeb) {
      return "http://127.0.0.1:8000";
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return "http://10.0.2.2:8000";
      case TargetPlatform.linux:
        return "http://127.0.0.1:8000";
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        return "http://127.0.0.1:8000";
    }
  }

  static String get storageUrl => "$kBaseUrl/storage";
}

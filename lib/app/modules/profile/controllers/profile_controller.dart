import 'dart:io';

import 'package:e_commerce_flutter/app/core/features/auth/data/providers/api_provider.dart';
import 'package:e_commerce_flutter/app/modules/profile/data/user.model.dart';
import 'package:e_commerce_flutter/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  // ------------------------------------------------------------
  // Dependencies
  // ------------------------------------------------------------

  final ApiProvider apiProvider = Get.find<ApiProvider>();
  final ImagePicker _picker = ImagePicker();

  // ------------------------------------------------------------
  // State
  // ------------------------------------------------------------

  final isLoading = false.obs;
  final isUploadingPicture = false.obs;

  final user = Rxn<UserModel>();

  final role = 'Premium Member'.obs;

  // ------------------------------------------------------------
  // Lifecycle
  // ------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    loadProfile();
  }

  // ------------------------------------------------------------
  // Profile
  // ------------------------------------------------------------

  Future<void> loadProfile() async {
    if (isLoading.value) return;

    // Render cached details immediately. A successful response below refreshes
    // them, while an omitted API avatar keeps the locally known image.
    await _loadCachedProfile();

    try {
      isLoading.value = true;

      final response = await apiProvider.getUser();

      debugPrint('PROFILE STATUS: ${response.statusCode}');
      debugPrint('PROFILE RESPONSE: ${response.data}');

      if (response.statusCode == 200) {
        final profile = _parseUser(response.data);

        if (profile != null) {
          final displayProfile = _preserveCachedAvatar(profile);
          user.value = displayProfile;
          await _saveProfile(displayProfile);

          debugPrint('PROFILE PICTURE: ${displayProfile.profilePicture}');

          return;
        }
      }

      await _loadCachedProfile();
    } catch (e, stackTrace) {
      debugPrint('PROFILE ERROR: $e');
      debugPrint('PROFILE STACK: $stackTrace');

      await _loadCachedProfile();

      _showError('Profile Error', 'Unable to load your profile.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProfile() async {
    await loadProfile();
  }

  UserModel? _parseUser(dynamic responseData) {
    try {
      if (responseData is! Map<String, dynamic>) {
        debugPrint('Invalid response type: ${responseData.runtimeType}');
        return null;
      }

      final data = responseData['data'];

      debugPrint('PROFILE DATA: $data');
      debugPrint('DATA TYPE: ${data.runtimeType}');

      Map<String, dynamic>? userData;

      // API returns:
      // "data": [...]
      if (data is List && data.isNotEmpty) {
        if (data.first is Map) {
          userData = Map<String, dynamic>.from(data.first);
        }
      }

      // Also support:
      // "data": {...}
      if (data is Map) {
        userData = Map<String, dynamic>.from(data);
      }

      if (userData == null) {
        debugPrint('No valid user data found.');
        return null;
      }

      debugPrint('RAW PROFILE PICTURE: ${userData['profile_picture']}');

      final profile = UserModel.fromJson(userData);

      debugPrint('MODEL PROFILE PICTURE: ${profile.profilePicture}');

      return profile;
    } catch (e, stackTrace) {
      debugPrint('PARSE PROFILE ERROR: $e');
      debugPrint('PARSE PROFILE STACK: $stackTrace');

      return null;
    }
  }

  UserModel _preserveCachedAvatar(UserModel profile) {
    final existingAvatar = user.value?.profilePicture?.trim();
    if ((profile.profilePicture?.trim().isNotEmpty ?? false) ||
        existingAvatar == null ||
        existingAvatar.isEmpty) {
      return profile;
    }

    return profile.copyWith(profilePicture: existingAvatar);
  }

  // ------------------------------------------------------------
  // Profile Picture
  // ------------------------------------------------------------

  Future<void> pickAndUploadProfilePicture() async {
    if (isUploadingPicture.value) return;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (pickedFile == null) {
        debugPrint('Image selection cancelled.');
        return;
      }

      final imageFile = File(pickedFile.path);

      if (!await imageFile.exists()) {
        _showError('Image Error', 'Selected image could not be found.');
        return;
      }

      final fileSize = await imageFile.length();

      debugPrint('IMAGE PATH: ${imageFile.path}');
      debugPrint('IMAGE SIZE: ${fileSize / 1024} KB');

      // Optional 5MB limit
      const maxFileSize = 5 * 1024 * 1024;

      if (fileSize > maxFileSize) {
        _showError(
          'Image Too Large',
          'Please select an image smaller than 5 MB.',
        );
        return;
      }

      await uploadProfilePicture(imageFile);
    } catch (e, stackTrace) {
      debugPrint('PICK IMAGE ERROR: $e');
      debugPrint('PICK IMAGE STACK: $stackTrace');

      _showError('Image Error', 'Failed to select the profile picture.');
    }
  }

  Future<void> uploadProfilePicture(File imageFile) async {
    if (isUploadingPicture.value) return;

    try {
      isUploadingPicture.value = true;

      debugPrint('--------------------------------');
      debugPrint('START PROFILE PICTURE UPLOAD');
      debugPrint('IMAGE PATH: ${imageFile.path}');
      debugPrint('IMAGE EXISTS: ${await imageFile.exists()}');
      debugPrint('--------------------------------');

      final response = await apiProvider.updateProfilePicture(imageFile);

      debugPrint('UPLOAD STATUS: ${response.statusCode}');

      debugPrint('UPLOAD RESPONSE: ${response.data}');

      if (response.statusCode == 200) {
        // If API returns the updated profile,
        // use it immediately.
        final updatedProfile = _parseUser(response.data);

        if (updatedProfile != null) {
          final displayProfile = _preserveCachedAvatar(updatedProfile);
          user.value = displayProfile;
          await _saveProfile(displayProfile);
        } else {
          // Otherwise reload from API.
          await loadProfile();
        }

        _showSuccess('Success', 'Profile picture updated successfully.');

        return;
      }

      _showError('Upload Failed', 'Unable to update your profile picture.');
    } catch (e, stackTrace) {
      debugPrint('UPLOAD ERROR: $e');
      debugPrint('UPLOAD STACK: $stackTrace');

      _showError('Upload Failed', _getErrorMessage(e));
    } finally {
      isUploadingPicture.value = false;
    }
  }

  // ------------------------------------------------------------
  // Local Cache
  // ------------------------------------------------------------

  Future<void> _saveProfile(UserModel profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('name', profile.name);
      await prefs.setString('email', profile.email);

      if (profile.phone != null && profile.phone!.isNotEmpty) {
        await prefs.setString('phone', profile.phone!);
      } else {
        await prefs.remove('phone');
      }

      // IMPORTANT:
      // Only update avatar when API gives a valid URL.
      if (profile.profilePicture != null &&
          profile.profilePicture!.trim().isNotEmpty) {
        await prefs.setString('avatar', profile.profilePicture!);

        debugPrint('AVATAR CACHE UPDATED: ${profile.profilePicture}');
      } else {
        // DON'T remove the existing cached avatar.
        debugPrint(
          'API profile_picture is null/empty. '
          'Keeping existing cached avatar.',
        );
      }
    } catch (e, stackTrace) {
      debugPrint('SAVE PROFILE ERROR: $e');
      debugPrint('SAVE PROFILE STACK: $stackTrace');
    }
  }

  Future<void> _loadCachedProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final name = prefs.getString('name');
      final email = prefs.getString('email');
      final phone = prefs.getString('phone');
      final avatar = prefs.getString('avatar');

      debugPrint(
        'CACHED PROFILE: '
        'name=$name, '
        'email=$email, '
        'phone=$phone, '
        'avatar=$avatar',
      );

      if (name == null && email == null && phone == null && avatar == null) {
        return;
      }

      user.value = UserModel(
        id: 0,
        name: name ?? 'Unknown User',
        email: email ?? '',
        phone: phone,
        emailVerifiedAt: null,
        profilePicture: avatar,
        createdAt: null,
        updatedAt: null,
      );
    } catch (e, stackTrace) {
      debugPrint('LOAD CACHE ERROR: $e');
      debugPrint('LOAD CACHE STACK: $stackTrace');
    }
  }

  // ------------------------------------------------------------
  // Logout
  // ------------------------------------------------------------

  Future<void> logout() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      // If your Laravel API has a logout endpoint,
      // call it here before clearing local data.
      //
      // await apiProvider.logout();

      final prefs = await SharedPreferences.getInstance();

      await prefs.clear();

      user.value = null;

      Get.offAllNamed(Routes.LOGIN);
    } catch (e, stackTrace) {
      debugPrint('LOGOUT ERROR: $e');
      debugPrint('LOGOUT STACK: $stackTrace');

      _showError('Logout Failed', 'Unable to logout. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------

  String _getErrorMessage(dynamic error) {
    final message = error.toString();

    if (message.contains('SocketException')) {
      return 'No internet connection.';
    }

    if (message.contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    }

    if (message.contains('DioException')) {
      return 'Unable to connect to the server.';
    }

    return 'Something went wrong. Please try again.';
  }

  void _showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}

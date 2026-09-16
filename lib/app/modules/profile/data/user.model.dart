import '../../../core/constants/app_constants.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? emailVerifiedAt;
  final String? profilePicture;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.emailVerifiedAt,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      emailVerifiedAt: json['email_verified_at'],
      profilePicture: _resolveProfilePicture(json['profile_picture']),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  static String? _resolveProfilePicture(dynamic value) {
    final path = value?.toString().trim();
    if (path == null || path.isEmpty) return null;

    final uri = Uri.tryParse(path);
    if (uri != null && uri.hasScheme) return path;

    // Laravel commonly returns either "avatars/name.jpg" or
    // "/storage/avatars/name.jpg". Convert both to an image URL the client
    // can render, while preserving already-complete URLs.
    final normalized = path.replaceFirst(RegExp(r'^/?storage/'), '');
    return '${AppConstants.storageUrl}/$normalized';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'email_verified_at': emailVerifiedAt,
      'profile_picture': profilePicture,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? emailVerifiedAt,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

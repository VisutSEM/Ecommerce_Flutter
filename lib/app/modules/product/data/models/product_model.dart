
// class ProductModel {
//   final int id;
//   final int categoryId;
//   final String name;
//   final String slug;
//   final String description;
//   final String price;
//   final bool featured_products;
//   final String? image;
//
//   ProductModel({
//     required this.id,
//     required this.categoryId,
//     required this.name,
//     required this.slug,
//     required this.description,
//     required this.price,
//     required this.featured_products,
//     this.image,
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       categoryId: json['category_id'],
//       name: json['name'] ?? '',
//       slug: json['slug'] ?? '',
//       description: json['description'] ?? '',
//       price: json['price'].toString(),
//       featured_products: json['featured_products'],
//       image: json['image'],
//     );
//   }
//
//   // Full image URL
//   String get imageUrl {
//     if (image == null || image!.isEmpty) return "";
//     return "${AppConstants.storageUrl}/$image";
//   }
// }

class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String slug;
  final String description;
  final double price;
  final bool isFeatured;
  final String image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.isFeatured,
    required this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      isFeatured: json['is_featured'] == 1 || json['is_featured'] == true,
      image: json['image'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'is_featured': isFeatured ? 1 : 0,
      'image': image,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Full image URL
  // String get imageUrl =>
  //     "${AppConstants.storageUrl}/$image";
}


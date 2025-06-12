import 'dart:io';

import 'package:e_commerce/features/add_products/add_product/domain/entities/product_entity_dashboard.dart';

class ProductModelDashboard {
  final String name;
  final String description;
  final num price;
  final String category;
  final File image;
  String? imageUrl;
  final num avgRating = 0;
  final num ratingCount = 0;
  final int sellingCount;

  ProductModelDashboard({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.imageUrl,
    this.sellingCount = 0,
  });

  factory ProductModelDashboard.fromEntity(
    ProductEntityDashboard addProductInputEntity,
  ) => ProductModelDashboard(
    name: addProductInputEntity.name,
    description: addProductInputEntity.description,
    price: addProductInputEntity.price,
    category: addProductInputEntity.category,
    image: addProductInputEntity.image,
    imageUrl: addProductInputEntity.imageUrl,
  );

  toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'sellingCount': sellingCount,
    };
  }
}

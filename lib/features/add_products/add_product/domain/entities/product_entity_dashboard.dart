import 'dart:io';

class ProductEntityDashboard {
  final String name;
  final String description;
  final num price;
  final String category;
  final File image;
  final num avgRating = 0;
  final num ratingCount = 0;
  String? imageUrl;

  ProductEntityDashboard({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.imageUrl,
  });
}

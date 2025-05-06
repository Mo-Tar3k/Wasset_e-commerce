import 'package:e_commerce/features/home/domain/entites/category_entity.dart';

class CategoryModel {
  final int id;
  final String categoryName;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    categoryName: json['categoryName'],
    imageUrl: json['imageUrl'],
  );

  CategoryEntity toEntity() =>
      CategoryEntity(id: id, categoryName: categoryName, imageUrl: imageUrl);
}

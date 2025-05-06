import 'package:e_commerce/core/entities/product_entity.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final num price;
  final num oldPrice;
  final String category;
  final String? imageURL;
  final double rating;
  final String serviceProviderImage;
  final String serviceProviderName;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.category,
    required this.imageURL,
    required this.rating,
    required this.serviceProviderImage,
    required this.serviceProviderName,
  });

  factory ProductModel.fromjson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      oldPrice: json['oldPrice'],
      category: json['category'],
      imageURL: json['imageURL'],
      rating: (json['rating'] as num).toDouble(),
      serviceProviderImage: json['serviceProviderImage'],
      serviceProviderName: json['serviceProviderName'],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,

      name: name,
      description: description,
      price: price,
      oldPrice: oldPrice,
      category: category,
      imageUrl: imageURL,
      rating: rating,
      serviceProviderName: serviceProviderName,
      serviceProviderImage: serviceProviderImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'oldPrice': oldPrice,
      'category': category,
      'imageURL': imageURL,
      'rating': rating,
      'serviceProviderImage': serviceProviderImage,
      'serviceProviderName': serviceProviderName,
    };
  }
}

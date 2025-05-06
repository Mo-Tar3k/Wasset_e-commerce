import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final num price;
  final num oldPrice;
  final String category;
  final String? imageUrl;
  final double rating;
  final String serviceProviderName;
  final String? serviceProviderImage;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.category,
    this.imageUrl,
    required this.rating,
    required this.serviceProviderName,
    required this.serviceProviderImage,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    oldPrice,
    category,
    imageUrl,
    rating,
    serviceProviderName,
    serviceProviderImage,
  ];
}

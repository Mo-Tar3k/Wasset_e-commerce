import 'package:e_commerce/core/entities/product_entity.dart';

ProductEntity getDummyProduct() {
  return ProductEntity(
    id: 1,
    name: 'Cool Sneakers',
    description: 'Stylish and comfortable sneakers for everyday wear.',
    price: 59.99,
    oldPrice: 79.99,
    category: 'Footwear',
    imageUrl: null, // Optional
    rating: 4.5,
    serviceProviderName: 'SneakerHub',
    serviceProviderImage: '',
  );
}

List<ProductEntity> getDummyProducts() {
  return List.generate(10, (index) => getDummyProduct());
}

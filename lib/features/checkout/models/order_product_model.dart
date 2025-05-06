// import 'package:e_commerce/features/home/domain/entites/cart_item_entity.dart';

// class OrderProductModel {
//   final String name;
//   final String imageUrl;
//   final double price;
//   final int quanitty;

//   OrderProductModel({
//     required this.name,
//     required this.imageUrl,
//     required this.price,
//     required this.quanitty,
//   });

//   factory OrderProductModel.fromEntity({
//     required CartItemEntity cartItemEntity,
//   }) {
//     return OrderProductModel(
//       name: cartItemEntity.productEntity.name,

//       imageUrl: cartItemEntity.productEntity.imageUrl!,
//       price: cartItemEntity.productEntity.price.toDouble(),
//       quanitty: cartItemEntity.quantity,
//     );
//   }

//   toJson() {
//     return {
//       'name': name,
//       'imageUrl': imageUrl,
//       'price': price,
//       'quantity': quanitty,
//     };
//   }
// }

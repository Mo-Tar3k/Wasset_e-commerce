// import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
// import 'package:e_commerce/features/checkout/presentation/views/data/models/order_product_model.dart';
// import 'package:e_commerce/features/checkout/presentation/views/data/models/shipping_address_model.dart';

// class OrderModel {
//   final double totalPrice;
//   final String uId;
//   final ShippingAddressModel shippingAddressModel;
//   final List<OrderProductModel> orderProducts;
//   final String paymentMethod;

//   OrderModel({
//     required this.totalPrice,
//     required this.uId,
//     required this.shippingAddressModel,
//     required this.orderProducts,
//     required this.paymentMethod,
//   });

//   factory OrderModel.fromEntity(OrderEntity orderEntity) {
//     return OrderModel(
//       totalPrice: orderEntity.cartEntity.calculateTotalPrice(),
//       uId: orderEntity.uID,
//       shippingAddressModel: ShippingAddressModel.fromEntity(
//         orderEntity.shippingAddressEntity,
//       ),
//       orderProducts:
//           orderEntity.cartEntity.cartItems
//               .map((e) => OrderProductModel.fromEntity(cartItemEntity: e))
//               .toList(),
//       paymentMethod: orderEntity.payWithCash! ? 'Cash' : 'Paypal',
//     );
//   }

//   toJson() => {
//     'totalPrice': totalPrice,
//     'uId': uId,
//     'shippingAddressModel': shippingAddressModel.toJson(),
//     'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
//     'paymentMethod': paymentMethod,
//   };
// }

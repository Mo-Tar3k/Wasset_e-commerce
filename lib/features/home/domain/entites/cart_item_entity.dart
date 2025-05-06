import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CartItemEntity extends Equatable {
  final ProductEntity productEntity;
  int quantity;
  CartItemEntity({required this.productEntity, this.quantity = 0});

  num calculateTotalPrice() {
    return productEntity.price * quantity;
  }

  increasQuantity() {
    quantity++;
  }

  decreasQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }

  @override
  List<Object?> get props => [productEntity];
}

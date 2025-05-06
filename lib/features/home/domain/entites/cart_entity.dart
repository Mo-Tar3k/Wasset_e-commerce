import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/features/home/domain/entites/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> cartItems;

  CartEntity(this.cartItems);

  addCartItem(CartItemEntity cartItem) {
    cartItems.add(cartItem);
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var cartItem in cartItems) {
      totalPrice += cartItem.calculateTotalPrice();
    }
    return totalPrice;
  }

  bool isExis(ProductEntity product) {
    for (var cartitem in cartItems) {
      if (cartitem.productEntity == product) {
        return true;
      }
    }
    return false;
  }

  CartItemEntity getCartItem(ProductEntity product) {
    for (var cartitem in cartItems) {
      if (cartitem.productEntity == product) {
        return cartitem;
      }
    }
    return CartItemEntity(productEntity: product, quantity: 1);
  }

  removeCartItem(CartItemEntity cartItem) {
    cartItems.remove(cartItem);
  }
}

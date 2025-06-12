import 'package:e_commerce/features/home/models/cart_model.dart';

abstract class CartRepo {
  Future<List<CartModel>> getCartItems();
  Future<List<CartModel>> addToCart(CartModel item);
  Future<void> deleteCartItem(int id);
  Future<void> updateQuantity(CartModel item); // ✅ أضف هذا السطر
  Future<String> getBasketId();
}

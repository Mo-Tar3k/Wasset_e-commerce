import 'package:bloc/bloc.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'package:e_commerce/features/home/repos/cart_repo.dart';
import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _repo;
  CartCubit(this._repo) : super(CartInitial());

  List<CartModel> cartItems = [];

  double get total => cartItems.fold(0, (sum, item) => sum + item.total);

  // Future<void> loadCart() async {
  //   emit(CartLoading());
  //   print("🧠 CartCubit - loading cart items..."); // ⬅️ هنا

  //   try {
  //     cartItems = await _repo.getCartItems() ?? []; // تأكد أنها مش null
  //     emit(CartLoaded(cartItems));
  //   } catch (e) {
  //     emit(CartError('Failed to load cart'));
  //   }
  // }
  Future<void> loadCart() async {
    emit(CartLoading());
    print("🧠 CartCubit - loading cart items...");

    try {
      cartItems = await _repo.getCartItems();

      // ✅ طبع محتوى السلة
      print("📦 CartCubit - loaded ${cartItems.length} items:");
      for (var item in cartItems) {
        print("🔸 ${item.name} x${item.quantity}");
      }

      emit(CartLoaded(cartItems));
    } catch (e) {
      print("❌ CartCubit - failed to load cart: $e");
      emit(CartError('Failed to load cart'));
    }
  }

  Future<void> addToCart(CartModel item) async {
    emit(CartLoading());
    try {
      await _repo.addToCart(item);
      cartItems = await _repo.getCartItems(); // ✅ refresh after add
      emit(CartLoaded(cartItems));
      emit(CartItemAdded());
    } catch (e) {
      emit(CartError('Failed to add item'));
    }
  }

  Future<void> removeItem(int id) async {
    emit(CartLoading());
    try {
      await _repo.deleteCartItem(id);
      cartItems = await _repo.getCartItems(); // ✅ ensure consistency
      emit(CartItemRemoved());
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError('Failed to delete item'));
    }
  }

  Future<void> updateQuantity(CartModel updatedItem) async {
    emit(CartLoading());
    try {
      await _repo.updateQuantity(updatedItem);
      cartItems = await _repo.getCartItems(); // ✅ refresh after update
      emit(CartLoaded(List.from(cartItems)));
    } catch (e) {
      emit(CartError('Failed to update quantity'));
    }
  }

  // ✅ Add product directly from ProductEntity
  void addProduct(ProductEntity productEntity) {
    final cartItem = CartModel(
      id: productEntity.id,
      name: productEntity.name,
      price: productEntity.price.toDouble(), // ✅ fix type conversion
      imageUrl: productEntity.imageUrl ?? '',
      quantity: 1,
    );
    addToCart(cartItem);
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      await _repo.clearCart(); // 🟢 دي تمسح من الـ API
      cartItems.clear(); // 🟢 دي تمسح من الذاكرة المحلية
      emit(CartLoaded([])); // 🟢 تبعت للمستمعين إن الكارت فاضي
    } catch (e) {
      emit(CartError('Failed to clear cart'));
    }
  }
}

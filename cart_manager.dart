class CartItem {
  final String id;
  final String name;
  int quantity;

  CartItem({required this.id, required this.name, required this.quantity});
}

class CartManager {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  void addItem(String id, String name) {
    final existingItemIndex = _cartItems.indexWhere((item) => item.id == id);

    if (existingItemIndex >= 0) {
      // Update quantity if item already exists
      _cartItems[existingItemIndex].quantity += 1;
    } else {
      // Add new item if it doesn't exist
      _cartItems.add(CartItem(id: id, name: name, quantity: 1));
    }
  }

  void updateItemQuantity(String id, int quantity) {
    final existingItemIndex = _cartItems.indexWhere((item) => item.id == id);

    if (existingItemIndex >= 0) {
      if (quantity > 0) {
        _cartItems[existingItemIndex].quantity = quantity;
      } else {
        // Remove item if quantity is zero
        _cartItems.removeAt(existingItemIndex);
      }
    }
  }
}

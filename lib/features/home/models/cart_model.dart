class CartModel {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {'ProductId': id, 'Quantity': quantity};

  double get total => price * quantity;
}

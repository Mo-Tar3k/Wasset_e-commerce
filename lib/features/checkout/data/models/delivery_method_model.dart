class DeliveryMethodModel {
  final int id;
  final String shortName;
  final String description;
  final String deliveryTime;
  final double cost;

  DeliveryMethodModel({
    required this.id,
    required this.shortName,
    required this.description,
    required this.deliveryTime,
    required this.cost,
  });

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) {
    return DeliveryMethodModel(
      id: json['id'],
      shortName: json['shortName'],
      description: json['description'],
      deliveryTime: json['deliveryTime'],
      cost: (json['cost'] as num).toDouble(),
    );
  }
}

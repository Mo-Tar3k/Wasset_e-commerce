import 'package:e_commerce/features/profile/domain/order_customer_entity.dart';

class OrderCustomerModel extends OrderCustomerEntity {
  const OrderCustomerModel({required int id, required String title})
    : super(id: id, title: title);

  factory OrderCustomerModel.fromJson(Map<String, dynamic> json) {
    return OrderCustomerModel(id: json['id'], title: json['title']);
  }
}

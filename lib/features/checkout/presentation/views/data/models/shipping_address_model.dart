import 'package:e_commerce/features/checkout/domain/entites/shipping_address_entity.dart';

class ShippingAddressModel {
  String? name;
  String? phone;
  String? address;
  String? city;
  String? email;
  String? adressDetails;

  ShippingAddressModel({
    this.name,
    this.phone,
    this.address,
    this.adressDetails,
    this.city,
    this.email,
  });
  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddressModel(
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      adressDetails: entity.adressDetails,
      city: entity.city,
      email: entity.email,
    );
  }
  @override
  String toString() {
    return '$address $adressDetails $city';
  }

  toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'adressDetails': adressDetails,
      'city': city,
      'email': email,
    };
  }
}

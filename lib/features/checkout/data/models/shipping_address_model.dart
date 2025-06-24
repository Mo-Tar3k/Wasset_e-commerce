import 'package:e_commerce/features/checkout/domain/entites/shipping_address_entity.dart';

class ShippingAddressModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String street;
  final String city;
  final String country;

  ShippingAddressModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.street,
    required this.city,
    required this.country,
  });

  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    final fullName = entity.name?.split(' ') ?? [];
    final firstName = fullName.isNotEmpty ? fullName.first : '';
    final lastName = fullName.length > 1 ? fullName.sublist(1).join(' ') : '';

    return ShippingAddressModel(
      firstName: firstName,
      lastName: lastName,
      phone: entity.phone ?? '',
      street: '${entity.address ?? ''} ${entity.adressDetails ?? ''}',
      city: entity.city ?? '',
      country: 'Egypt', // أو اجعلها قابلة للتعديل إذا كانت من UI
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "street": street,
      "city": city,
      "country": country,
    };
  }
}

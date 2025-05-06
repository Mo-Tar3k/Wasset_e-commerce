class ShippingAddressEntity {
  String? name;
  String? address;
  String? phone;
  String? city;
  String? email;
  String? adressDetails;

  ShippingAddressEntity({
    this.name,
    this.address,
    this.phone,
    this.city,
    this.email,
    this.adressDetails,
  });

  @override
  String toString() {
    return '$adressDetails $address  $city ';
  }
}

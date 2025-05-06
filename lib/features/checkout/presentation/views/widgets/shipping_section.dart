import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/shipping_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingSection extends StatefulWidget {
  const ShippingSection({super.key});

  @override
  State<ShippingSection> createState() => _ShippingSectionState();
}

class _ShippingSectionState extends State<ShippingSection>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var orderEntity = context.read<OrderEntity>();
    return Column(
      children: [
        SizedBox(height: 33),
        ShippingItem(
          isSelected: selectedIndex == 0,
          title: 'Pay on delivery',
          subtitle: 'Delivery to your address',
          price: (orderEntity.calculateTotalPrice() + 30).toString(),
          onTap: () {
            selectedIndex = 0;
            setState(() {});
            orderEntity.payWithCash = true;
          },
        ),
        SizedBox(height: 16),
        ShippingItem(
          onTap: () {
            selectedIndex = 1;
            setState(() {});
            orderEntity.payWithCash = false;
          },
          isSelected: selectedIndex == 1,
          title: 'Online payment',
          subtitle: 'Select your payment method',
          price: orderEntity.calculateTotalPrice().toString(),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

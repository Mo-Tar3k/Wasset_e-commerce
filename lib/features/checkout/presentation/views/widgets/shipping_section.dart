import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/delivery_method_api.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/checkout/data/models/delivery_method_model.dart';
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
  int? selectedIndex;
  List<DeliveryMethodModel> methods = [];
  bool isLoading = true;
  late DeliveryMethodApi api;
  late String? token;

  @override
  void initState() {
    super.initState();
    api = DeliveryMethodApi(Dio());
    token = Prefs.getString('token');
    fetchDeliveryMethods();
  }

  Future<void> fetchDeliveryMethods() async {
    try {
      if (token == null) throw Exception('Token is null');

      final data = await api.fetchDeliveryMethods(token!);
      setState(() {
        methods = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to load delivery methods')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final orderEntity = context.read<OrderEntity>();

    if (isLoading) return const Center(child: CircularProgressIndicator());

    return Column(
      children:
          methods.asMap().entries.map((entry) {
            final index = entry.key;
            final method = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShippingItem(
                isSelected: selectedIndex == index,
                title: method.shortName,
                subtitle:
                    '${method.description} (${method.deliveryTime})', // وصف كامل
                price: '${method.cost.toStringAsFixed(2)} L.E',
                onTap: () async {
                  if (token == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("⚠️ Token is null, please login again"),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    selectedIndex = index;
                    orderEntity.payWithCash = method.shortName == "Cash";
                    orderEntity.deliveryMethodId = method.id;
                  });

                  try {
                    await api.updateDeliveryMethod(method.id, token!);
                    print('Delivery method updated: ${method.shortName}');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("⚠️ Failed to update delivery method"),
                      ),
                    );
                  }
                },
              ),
            );
          }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

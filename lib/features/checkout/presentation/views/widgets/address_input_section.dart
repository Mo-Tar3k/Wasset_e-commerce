import 'package:e_commerce/core/widgets/custom_text_field.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressInputSection extends StatelessWidget {
  const AddressInputSection({
    super.key,
    required this.formKey,
    required this.valueListenable,
  });
  final GlobalKey<FormState> formKey;
  final ValueListenable<AutovalidateMode> valueListenable;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<AutovalidateMode>(
        valueListenable: valueListenable,
        builder:
            (context, value, child) => Form(
              key: formKey,
              autovalidateMode: value,
              child: Column(
                children: [
                  SizedBox(height: 24),
                  CustomTextFieldForm(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.name =
                          value!;
                    },
                    labelText: 'Full Name',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldForm(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.email =
                          value!;
                    },
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldForm(
                    onSaved: (value) {
                      context
                          .read<OrderEntity>()
                          .shippingAddressEntity
                          .address = value!;
                    },
                    labelText: 'Address',
                    textInputType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldForm(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.city =
                          value!;
                    },
                    labelText: 'City',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldForm(
                    onSaved: (value) {
                      context
                          .read<OrderEntity>()
                          .shippingAddressEntity
                          .adressDetails = value!;
                    },
                    labelText: 'Floor / Building Number',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldForm(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.phone =
                          value!;
                    },
                    labelText: 'Phone Number',
                    textInputType: TextInputType.phone,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

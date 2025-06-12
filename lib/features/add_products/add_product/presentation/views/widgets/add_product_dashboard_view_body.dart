import 'dart:io';

import 'package:e_commerce/features/add_products/add_product/domain/entities/product_entity_dashboard.dart';
import 'package:e_commerce/features/add_products/add_product/presentation/manager/cubit/add_product_dashboard_cubit.dart';
import 'package:e_commerce/features/add_products/add_product/presentation/views/widgets/image_field_dashboard.dart';
import 'package:e_commerce/features/add_products/core/widgets/category_dropdown_dashboard_field.dart';
import 'package:e_commerce/features/add_products/core/widgets/custom_button_dashboard.dart';
import 'package:e_commerce/features/add_products/core/widgets/custom_text_field_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductDashboardViewBody extends StatefulWidget {
  const AddProductDashboardViewBody({super.key});

  @override
  State<AddProductDashboardViewBody> createState() =>
      _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductDashboardViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String name, description;
  late int category;
  late num price;
  File? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(height: 16),
              CustomTextFieldFormDashboard(
                onSaved: (value) {
                  name = value!;
                },
                labelText: 'Product Name',
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 16),
              CustomTextFieldFormDashboard(
                onSaved: (value) {
                  price = num.parse(value!);
                },
                labelText: 'Product Price',
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 16),
              CategoryDropdownFieldDashboard(
                onSaved: (value) {
                  category = value!;
                },
                labelText: 'Category',
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              CustomTextFieldFormDashboard(
                onSaved: (value) {
                  description = value!;
                },
                labelText: 'Product Description',
                textInputType: TextInputType.text,
                maxLines: 5,
              ),
              SizedBox(height: 16),
              ImageFieldDashboard(
                onFileChanged: (image) {
                  this.image = image;
                },
              ),
              SizedBox(height: 24),
              CustomButtonDashboard(
                onPressed: () {
                  if (image != null) {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ProductEntityDashboard input = ProductEntityDashboard(
                        name: name,
                        price: price,
                        category: category.toString(), // Convert int to String
                        description: description,
                        image: image!,
                      );
                      context.read<AddProductDashboardCubit>().addProduct(
                        input,
                      );
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  } else {
                    showError(context);
                  }
                },
                text: 'Add Product',
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void showError(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Please select an image')));
  }
}

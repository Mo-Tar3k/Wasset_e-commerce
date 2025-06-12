import 'package:e_commerce/features/add_products/add_product/presentation/manager/cubit/add_product_dashboard_cubit.dart';
import 'package:e_commerce/features/add_products/add_product/presentation/views/widgets/add_product_dashboard_view_body.dart';
import 'package:e_commerce/features/add_products/core/helper_functions/build_error_bar_dashboard.dart';
import 'package:e_commerce/features/add_products/core/widgets/custom_progres_hud_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductsViewBodyBlocBuilderDashboard extends StatelessWidget {
  const AddProductsViewBodyBlocBuilderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductDashboardCubit, AddProductDashboardState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          buildBarDashboard(context, "Product added successfully");
        }
        if (state is AddProductFailure) {
          buildBarDashboard(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomProgresHUDDashboard(
          isLoading: state is AddProductLoading,
          child: AddProductDashboardViewBody(),
        );
      },
    );
  }
}

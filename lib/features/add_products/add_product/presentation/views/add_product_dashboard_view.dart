import 'package:e_commerce/core/services/get_it_service.dart';
import 'package:e_commerce/features/add_products/add_product/presentation/manager/cubit/add_product_dashboard_cubit.dart';
import 'package:e_commerce/features/add_products/add_product/presentation/views/widgets/add_products_dashboard_view_body_bloc_builder.dart';
import 'package:e_commerce/features/add_products/core/repos/images_repo/images_dashboard_repo.dart';
import 'package:e_commerce/features/add_products/core/repos/product_repo/products_dashboard_repo.dart';
import 'package:e_commerce/features/add_products/core/widgets/build_app_bar_dash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductDashboardView extends StatelessWidget {
  const AddProductDashboardView({super.key});
  static const routeName = 'add-product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarDashboard('Add Product'),
      body: BlocProvider(
        create:
            (context) => AddProductDashboardCubit(
              getIt.get<ImagesRepoDashboard>(),
              getIt.get<ProductsRepoDashboard>(),
            ),
        child: AddProductsViewBodyBlocBuilderDashboard(),
      ),
    );
  }
}

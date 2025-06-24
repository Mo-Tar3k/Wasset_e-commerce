import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_progres_hud.dart';
import 'package:e_commerce/features/checkout/presentation/manger/add_order_cubit/add_order_cubit.dart';
import 'package:e_commerce/features/payment/presentation/views/payment_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrderCubitBlocBuilder extends StatelessWidget {
  const AddOrderCubitBlocBuilder({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderState>(
      listener: (context, state) {
        if (state is AddOrderSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => PaymentSuccessView(
                    orderId: '#51456151',
                  ), // حط الـ ID الحقيقي لو عندك
            ),
          );
        }
        if (state is AddOrderFailure) {
          showMassgeBar(context, state.errMassage);
        }
      },
      builder: (context, state) {
        return CustomProgresHUD(
          isLoading: state is AddOrderLoading,
          child: child,
        );
      },
    );
  }
}

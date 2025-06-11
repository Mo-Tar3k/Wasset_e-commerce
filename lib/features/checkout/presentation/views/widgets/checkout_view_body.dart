import 'package:e_commerce/core/helper_funcations/show_error_bar.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/features/checkout/domain/entites/order_entity.dart';
import 'package:e_commerce/features/checkout/presentation/manger/add_order_cubit/add_order_cubit.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/checkout_steps.dart';
import 'package:e_commerce/features/checkout/presentation/views/widgets/checkout_steps_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  late PageController pageController;
  ValueNotifier<AutovalidateMode> valueNotifier = ValueNotifier(
    AutovalidateMode.disabled,
  );

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    valueNotifier.dispose();
    super.dispose();
  }

  int currentPageIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListenableProvider<PageController>.value(
        value: pageController,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CheckoutSteps(
              currentPageIndex: currentPageIndex,
              pageController: pageController,
            ),
            Expanded(
              child: CheckoutStepsPageView(
                valueListenable: valueNotifier,
                pageController: pageController,
                formKey: _formKey,
              ),
            ),
            CustomButton(
              onPressed: () {
                if (currentPageIndex == 0) {
                  _handleShippingSectionValidation(context);
                } else if (currentPageIndex == 1) {
                  _handleAddressValidation();
                } else {
                  var orderEntity = context.read<OrderEntity>();
                  context.read<AddOrderCubit>().addOrder(order: orderEntity);
                }
              },
              text: getNextButtonText(currentPageIndex),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _handleShippingSectionValidation(BuildContext context) {
    if (context.read<OrderEntity>().payWithCash != null) {
      pageController.animateToPage(
        currentPageIndex < 2 ? currentPageIndex + 1 : currentPageIndex,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
      );
    } else {
      showMassgeBar(context, "Please select a payment method");
    }
  }

  String getNextButtonText(int currentPageIndex) {
    switch (currentPageIndex) {
      case 0:
        return 'Next';
      case 1:
        return 'Next';
      case 2:
        return 'Pay with Stripe';
      default:
        return 'Next';
    }
  }

  void _handleAddressValidation() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      pageController.animateToPage(
        currentPageIndex < 2 ? currentPageIndex + 1 : currentPageIndex,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
      );
    } else {
      valueNotifier.value = AutovalidateMode.always;
    }
  }
}

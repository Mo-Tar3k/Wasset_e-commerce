import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/custom_button_navigation_bar.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/main_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const routeName = 'main_view';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentViewIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CartCubit>(context),

      child: Scaffold(
        bottomNavigationBar:
            CustomButtomNavigationBar.CustomButtonNavigationBar(
              onItemTapped: (index) {
                currentViewIndex = index;

                setState(() {});
              },
            ),
        body: SafeArea(
          child: MainViewBodyBlocConsumer(currentViewIndex: currentViewIndex),
        ),
      ),
    );
  }
}

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:e_commerce/core/widgets/search_text_field.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/products_grid_view_bloc_builder.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/featured_list.dart';
import 'package:e_commerce/features/home/presentation/views/widgets/products_view_header.dart';
import 'package:e_commerce/features/search/presentation/views/search_view.dart';
import 'package:e_commerce/features/chatbot/presentation/widgets/chatbot_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: KTopPadding),
                    CustomHomeAppBar(),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        print("Going to search screen...");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BlocProvider.value(
                                  value: context.read<CartCubit>(),
                                  child: const SearchView(),
                                ),
                          ),
                        );
                      },
                      child: IgnorePointer(
                        child:
                            const SearchTextField(), // هي نفس الـ TextField بس غير قابلة للتفاعل
                      ),
                    ),

                    SizedBox(height: 12),
                    FeaturedList(),
                    SizedBox(height: 12),
                    BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        int productsLength = 0;

                        if (state is ProductsSuccess) {
                          productsLength = state.products.length;
                        }

                        return ProductsViewHeader(
                          productsLength: productsLength,
                        );
                      },
                    ),

                    SizedBox(height: 8),
                  ],
                ),
              ),
              ProductsGridViewBlocBuilder(),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const ChatbotDialog(),
              );
            },
            backgroundColor:
                Colors.transparent, // Transparent to show custom design
            elevation: 0, // Remove default shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.smart_toy, // Robot icon to represent chatbot
                color: Colors.white,
                size: 30, // Slightly larger icon for better visibility
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/product_details/presentation/views/product_reviews_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {},
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product.imageUrl ?? '',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (product.oldPrice > product.price)
                        Text(
                          '${product.oldPrice} L.E',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      if (product.oldPrice > product.price)
                        const SizedBox(width: 8),
                      Text(
                        '${product.price} L.E',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        double starFill = (product.rating - index).clamp(0, 1);
                        if (starFill == 1) {
                          return const Icon(Icons.star, color: Colors.amber);
                        } else if (starFill > 0) {
                          return ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Colors.amber, Colors.grey.shade300],
                                stops: [starFill, starFill],
                              ).createShader(bounds);
                            },
                            child: const Icon(Icons.star, color: Colors.white),
                          );
                        } else {
                          return Icon(Icons.star, color: Colors.grey.shade300);
                        }
                      }),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            ProductReviewsView.routeName,
                            arguments: product.id,
                          );
                        },
                        child: Text(
                          '( reviews)',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isDarkMode(context)
                              ? AppColors.lightDarkMode
                              : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            product.serviceProviderImage ?? '',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.serviceProviderName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'I am a trusted retailer based in Cairo, Egypt with over 10 years of experience in the industry. Known for exceptional customer service.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Add to Cart',
              onPressed: () {
                context.read<CartCubit>().addToCart(
                  CartModel(
                    id: product.id,
                    name: product.name,
                    price: product.price.toDouble(),
                    imageUrl: product.imageUrl ?? '',
                    quantity: 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';
import 'package:e_commerce/core/entities/product_entity.dart';
import 'package:e_commerce/features/home/presentation/views/cubits/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/features/product_details/presentation/views/product_details_view.dart';
import 'product_card.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).chain(CurveTween(curve: Curves.elasticInOut)).animate(_controller);
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    context.read<CartCubit>().addProduct(widget.productEntity);
    _controller.forward().then((_) => _controller.reverse());
    _confettiController.play();
  }

  void _goToDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => BlocProvider.value(
              value: BlocProvider.of<CartCubit>(context),
              child: ProductDetailsView(product: widget.productEntity),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProductCard(
      productEntity: widget.productEntity,
      onAdd: _handleAdd,
      onTap: _goToDetails,
      scaleAnimation: _scaleAnimation,
    );
  }
}

import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_images.dart';
import 'package:e_commerce/features/search/presentation/views/cubits/search_cubit/search_cubit.dart';
import 'package:e_commerce/features/search/presentation/views/widgets/price_filter_sheet.dart';
import 'package:e_commerce/features/search/presentation/views/widgets/sort_options_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white(context),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A000000),
            blurRadius: 9,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          context.read<SearchCubit>().updateQuery(value);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: 20,
            child: Center(child: Image.asset(Assets.assetsImagesSearchIcon)),
          ),

          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔽 Price Filter Icon
              IconButton(
                icon: SizedBox(
                  width: 20,
                  child: Center(child: Image.asset(Assets.assetsImagesSortBy)),
                ),
                onPressed: () {
                  final parentContext = context;

                  showModalBottomSheet(
                    context: parentContext,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder:
                        (_) => PriceFilterSheet(parentContext: parentContext),
                  );
                },
              ),

              // 🔽 Sort Options Icon
              IconButton(
                onPressed: () {
                  final currentContext = context;
                  showModalBottomSheet(
                    context: currentContext,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder:
                        (_) => SortOptionsBottomSheet(
                          parentContext: currentContext,
                        ), // ✅ مرر السياق
                  );
                },
                icon: SizedBox(
                  width: 20,
                  child: Center(child: Image.asset(Assets.assetsImagesFilter)),
                ),
              ),
            ],
          ),

          fillColor: AppColors.gray(context),
          filled: true,
          labelText: "Search...",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

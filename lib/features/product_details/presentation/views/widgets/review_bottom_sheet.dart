import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/product_details/presentation/views/widgets/review_input_dialog.dart';
import 'package:flutter/material.dart';

void showReviewInputBottomSheet(
  BuildContext context,
  int productId,
  VoidCallback onSubmitted, {
  bool validateRating = false,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white(context),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: ReviewInputDialogContent(
          productId: productId,
          onSubmitted: onSubmitted,
          validateRating: validateRating, // ✅ جديد
        ),
      );
    },
  );
}

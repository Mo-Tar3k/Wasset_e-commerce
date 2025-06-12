import 'package:e_commerce/core/services/api_service.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ReviewInputDialogContent extends StatefulWidget {
  final int productId;
  final VoidCallback onSubmitted;
  final bool validateRating; // ✅ جديد

  const ReviewInputDialogContent({
    super.key,
    required this.productId,
    required this.onSubmitted,
    this.validateRating = false, // ✅ افتراضي
  });

  @override
  State<ReviewInputDialogContent> createState() =>
      _ReviewInputDialogContentState();
}

class _ReviewInputDialogContentState extends State<ReviewInputDialogContent> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Text(
              'What is your rate?',
              style: TextStyle(
                color: AppColors.blac(context),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  iconSize: 36,
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => rating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 12),
            Text(
              'Please share your opinion\nabout the product',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.blac(context),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Your review',
                filled: true,
                fillColor: AppColors.white(context),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Submit',
              onPressed: () async {
                if (widget.validateRating && rating == 0) {
                  return;
                }

                try {
                  final now = DateTime.now().toUtc();
                  await _apiService.addProductReview(
                    comment: _controller.text,
                    rating: rating.toInt(),
                    productId: widget.productId,
                    date: now,
                  );
                  Navigator.pop(context);
                  widget.onSubmitted();
                } catch (e) {
                  Navigator.pop(context);

                  String errorMessage = 'Something went wrong';
                  final errorStr = e.toString();
                  final match = RegExp(
                    r"errors: \[(.*?)\]",
                  ).firstMatch(errorStr);
                  if (match != null) errorMessage = match.group(1)!;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(errorMessage)));
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

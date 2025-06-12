import 'package:e_commerce/core/services/api_service.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/product_details/presentation/views/widgets/review_input_dialog.dart';
import 'package:e_commerce/features/product_details/presentation/views/widgets/review_list.dart';
import 'package:flutter/material.dart';

class ProductReviewsViewBody extends StatefulWidget {
  final int productId;
  const ProductReviewsViewBody({super.key, required this.productId});

  @override
  State<ProductReviewsViewBody> createState() => _ProductReviewsViewBodyState();
}

class _ProductReviewsViewBodyState extends State<ProductReviewsViewBody> {
  final ApiService _apiService = ApiService();
  List<dynamic> reviews = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      final fetched = await _apiService.getProductReviews(widget.productId);
      setState(() {
        reviews = fetched;
        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        reviews = [];
        isLoading = false;
        errorMessage = 'No reviews found for this product.';
      });
    }
  }

  double _getAverageRating() {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<double>(
      0,
      (sum, r) => sum + (r['rating'] ?? 0).toDouble(),
    );
    return total / reviews.length;
  }

  Map<int, int> _getRatingDistribution() {
    Map<int, int> distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in reviews) {
      int rating = (review['rating'] ?? 0).toInt();
      if (distribution.containsKey(rating)) {
        distribution[rating] = distribution[rating]! + 1;
      }
    }
    return distribution;
  }

  void showAddReviewDialog() {
    showReviewInputBottomSheet(
      context,
      widget.productId,
      fetchReviews,
      validateRating: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
          children: [
            ListTile(
              title: const Text('Write a comment...'),
              leading: const Icon(Icons.edit),
              onTap: showAddReviewDialog,
            ),
            const Divider(),
            if (reviews.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 28),
                    const SizedBox(width: 6),
                    Text(
                      _getAverageRating().toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '(${reviews.length} reviews)',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(5, (i) {
                    int star = 5 - i;
                    int count = _getRatingDistribution()[star] ?? 0;
                    double percent =
                        count / (reviews.isEmpty ? 1 : reviews.length);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Text('$star ★', style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: percent,
                              backgroundColor: Colors.grey[200],
                              color: Colors.amber,
                              minHeight: 8,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('$count'),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            else
              Expanded(child: ReviewList(reviews: reviews)),
          ],
        );
  }
}

void showReviewInputBottomSheet(
  BuildContext context,
  int productId,
  VoidCallback onSubmitted, {
  bool validateRating = false,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Review Dialog',
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: AppColors.white(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Container(
                child: ReviewInputDialogContent(
                  productId: productId,
                  onSubmitted: onSubmitted,
                  validateRating: validateRating,
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}

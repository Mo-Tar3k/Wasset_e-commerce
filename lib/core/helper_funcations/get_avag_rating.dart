import 'package:e_commerce/core/models/review_model.dart';

num getAvagRating(List<ReviewModel> reviews) {
  if (reviews.isEmpty) {
    return 0;
  }
  num sum = 0;
  for (var review in reviews) {
    sum += review.ratting;
  }
  return sum / reviews.length;
}

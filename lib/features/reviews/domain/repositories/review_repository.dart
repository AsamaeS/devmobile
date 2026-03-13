import 'package:flutter_clean_architecture/features/reviews/domain/entities/review_entity.dart';

abstract class ReviewRepository {
  Future<List<ReviewEntity>> getReviewsForGuide(int guideId);
  Future<ReviewEntity> addReview(ReviewEntity review);
}

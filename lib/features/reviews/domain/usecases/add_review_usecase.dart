import 'package:flutter_clean_architecture/features/reviews/domain/entities/review_entity.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/repositories/review_repository.dart';

class AddReviewUseCase {
  final ReviewRepository repository;

  AddReviewUseCase(this.repository);

  Future<ReviewEntity> call(ReviewEntity review) {
    return repository.addReview(review);
  }
}

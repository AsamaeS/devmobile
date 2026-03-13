import 'package:flutter_clean_architecture/features/reviews/domain/entities/review_entity.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/repositories/review_repository.dart';

class GetReviewsUseCase {
  final ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  Future<List<ReviewEntity>> call(int guideId) {
    return repository.getReviewsForGuide(guideId);
  }
}

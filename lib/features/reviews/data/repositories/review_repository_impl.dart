import 'package:flutter_clean_architecture/features/reviews/data/datasources/review_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/reviews/data/models/review_model.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/entities/review_entity.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<ReviewEntity> addReview(ReviewEntity review) async {
    try {
      final model = ReviewModel.fromEntity(review);
      return await remoteDataSource.addReview(model);
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }

  @override
  Future<List<ReviewEntity>> getReviewsForGuide(int guideId) async {
    try {
      return await remoteDataSource.getReviewsForGuide(guideId);
    } catch (e) {
      throw Exception('Failed to fetch reviews: $e');
    }
  }
}

import 'package:flutter_clean_architecture/features/reviews/data/models/review_model.dart';
import 'package:uuid/uuid.dart';

abstract class ReviewRemoteDataSource {
  Future<List<ReviewModel>> getReviewsForGuide(int guideId);
  Future<ReviewModel> addReview(ReviewModel review);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final _uuid = const Uuid();
  
  // In-memory mock storage
  final List<ReviewModel> _mockReviews = [
    ReviewModel(
      id: 'rev-1',
      guideId: 1,
      touristName: 'Alice Smith',
      rating: 5.0,
      comment: 'Ahmed was amazing! We saw hidden spots in the Medina.',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ReviewModel(
      id: 'rev-2',
      guideId: 1,
      touristName: 'Marc Dubois',
      rating: 4.0,
      comment: 'Very informative, but the walking was a bit intense.',
      date: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ];

  @override
  Future<List<ReviewModel>> getReviewsForGuide(int guideId) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulating network
    return _mockReviews.where((r) => r.guideId == guideId).toList();
  }

  @override
  Future<ReviewModel> addReview(ReviewModel review) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulating network
    
    final newReview = ReviewModel(
      id: _uuid.v4(),
      guideId: review.guideId,
      touristName: review.touristName,
      rating: review.rating,
      comment: review.comment,
      date: review.date,
    );
    
    _mockReviews.insert(0, newReview);
    return newReview;
  }
}

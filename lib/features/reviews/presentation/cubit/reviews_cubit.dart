import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/entities/review_entity.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/usecases/get_reviews_usecase.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/cubit/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetReviewsUseCase getReviewsUseCase;
  final AddReviewUseCase addReviewUseCase;

  ReviewsCubit({
    required this.getReviewsUseCase,
    required this.addReviewUseCase,
  }) : super(ReviewsInitial());

  Future<void> loadReviewsForGuide(int guideId) async {
    emit(ReviewsLoading());
    try {
      final reviews = await getReviewsUseCase(guideId);
      emit(ReviewsLoaded(reviews));
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }

  Future<void> submitReview({
    required int guideId,
    required String touristName,
    required double rating,
    required String comment,
  }) async {
    emit(ReviewSubmitting());
    try {
      final review = ReviewEntity(
        id: '', // Handled by datasource
        guideId: guideId,
        touristName: touristName,
        rating: rating,
        comment: comment,
        date: DateTime.now(),
      );
      final newReview = await addReviewUseCase(review);
      emit(ReviewSubmitSuccess(newReview));
    } catch (e) {
      emit(ReviewsError(e.toString()));
    }
  }
}

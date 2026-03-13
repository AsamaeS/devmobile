import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/entities/review_entity.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<ReviewEntity> reviews;

  const ReviewsLoaded(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

class ReviewSubmitting extends ReviewsState {}

class ReviewSubmitSuccess extends ReviewsState {
  final ReviewEntity review;

  const ReviewSubmitSuccess(this.review);

  @override
  List<Object?> get props => [review];
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError(this.message);

  @override
  List<Object?> get props => [message];
}

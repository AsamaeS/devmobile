import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final int guideId;
  final String touristName;
  final double rating;
  final String comment;
  final DateTime date;

  const ReviewEntity({
    required this.id,
    required this.guideId,
    required this.touristName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  List<Object?> get props => [id, guideId, touristName, rating, comment, date];
}

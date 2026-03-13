import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String id;
  final int guideId;
  final String touristName;
  final DateTime date;
  final int guests;
  final double totalPrice;
  final String status; // 'pending', 'confirmed', 'completed'
  final String? message;

  const BookingEntity({
    required this.id,
    required this.guideId,
    required this.touristName,
    required this.date,
    required this.guests,
    required this.totalPrice,
    required this.status,
    this.message,
  });

  @override
  List<Object?> get props => [id, guideId, touristName, date, guests, totalPrice, status, message];
}

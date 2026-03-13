import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/booking/domain/entities/booking_entity.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingCreated extends BookingState {
  final BookingEntity booking;

  const BookingCreated(this.booking);

  @override
  List<Object?> get props => [booking];
}

class PaymentProcessing extends BookingState {}

class PaymentSuccess extends BookingState {
  final String transactionId;

  const PaymentSuccess(this.transactionId);

  @override
  List<Object?> get props => [transactionId];
}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object?> get props => [message];
}

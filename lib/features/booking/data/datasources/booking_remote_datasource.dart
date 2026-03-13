import 'dart:math';
import 'package:flutter_clean_architecture/features/booking/data/models/booking_model.dart';
import 'package:uuid/uuid.dart';

abstract class BookingRemoteDataSource {
  Future<BookingModel> createBooking(BookingModel booking);
  Future<bool> processPayment(String bookingId, double amount);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final _uuid = const Uuid();

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate API creating an ID
    final newBooking = BookingModel(
      id: _uuid.v4(),
      guideId: booking.guideId,
      touristName: booking.touristName,
      date: booking.date,
      guests: booking.guests,
      totalPrice: booking.totalPrice,
      status: 'pending',
      message: booking.message,
    );
    
    return newBooking;
  }

  @override
  Future<bool> processPayment(String bookingId, double amount) async {
    // Simulate payment gateway delay
    await Future.delayed(const Duration(seconds: 2));
    
    // 95% success rate for mock
    if (Random().nextDouble() > 0.05) {
      return true;
    } else {
      throw Exception('Payment failed due to simulated bank rejection.');
    }
  }
}

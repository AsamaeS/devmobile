import 'package:flutter_clean_architecture/features/booking/domain/entities/booking_entity.dart';

abstract class BookingRepository {
  Future<BookingEntity> createBooking(BookingEntity booking);
  Future<bool> processPayment(String bookingId, double amount);
}

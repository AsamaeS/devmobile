import 'package:flutter_clean_architecture/features/booking/domain/entities/booking_entity.dart';
import 'package:flutter_clean_architecture/features/booking/domain/repositories/booking_repository.dart';

class CreateBookingUseCase {
  final BookingRepository repository;

  CreateBookingUseCase(this.repository);

  Future<BookingEntity> call(BookingEntity booking) {
    return repository.createBooking(booking);
  }
}

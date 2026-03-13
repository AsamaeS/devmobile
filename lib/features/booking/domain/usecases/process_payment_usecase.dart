import 'package:flutter_clean_architecture/features/booking/domain/repositories/booking_repository.dart';

class ProcessPaymentUseCase {
  final BookingRepository repository;

  ProcessPaymentUseCase(this.repository);

  Future<bool> call(String bookingId, double amount) {
    return repository.processPayment(bookingId, amount);
  }
}

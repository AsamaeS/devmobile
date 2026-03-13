import 'package:flutter_clean_architecture/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/booking/data/models/booking_model.dart';
import 'package:flutter_clean_architecture/features/booking/domain/entities/booking_entity.dart';
import 'package:flutter_clean_architecture/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<BookingEntity> createBooking(BookingEntity booking) async {
    try {
      final model = BookingModel.fromEntity(booking);
      final resultModel = await remoteDataSource.createBooking(model);
      return resultModel; // Resulting model is an entity
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  @override
  Future<bool> processPayment(String bookingId, double amount) async {
    try {
      return await remoteDataSource.processPayment(bookingId, amount);
    } catch (e) {
      throw Exception('Failed to process payment: $e');
    }
  }
}

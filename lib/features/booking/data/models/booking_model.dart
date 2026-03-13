import 'package:flutter_clean_architecture/features/booking/domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.guideId,
    required super.touristName,
    required super.date,
    required super.guests,
    required super.totalPrice,
    required super.status,
    super.message,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      guideId: json['guideId'],
      touristName: json['touristName'],
      date: DateTime.parse(json['date']),
      guests: json['guests'],
      totalPrice: json['totalPrice'].toDouble(),
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guideId': guideId,
      'touristName': touristName,
      'date': date.toIso8601String(),
      'guests': guests,
      'totalPrice': totalPrice,
      'status': status,
      'message': message,
    };
  }
  
  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      guideId: entity.guideId,
      touristName: entity.touristName,
      date: entity.date,
      guests: entity.guests,
      totalPrice: entity.totalPrice,
      status: entity.status,
      message: entity.message,
    );
  }
}

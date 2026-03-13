import 'package:flutter_clean_architecture/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.totalEarnings,
    required super.upcomingTours,
    required super.pendingRequests,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalEarnings: json['totalEarnings'],
      upcomingTours: json['upcomingTours'],
      pendingRequests: json['pendingRequests'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEarnings': totalEarnings,
      'upcomingTours': upcomingTours,
      'pendingRequests': pendingRequests,
    };
  }

  factory DashboardModel.fromEntity(DashboardEntity entity) {
    return DashboardModel(
      totalEarnings: entity.totalEarnings,
      upcomingTours: entity.upcomingTours,
      pendingRequests: entity.pendingRequests,
    );
  }
}

import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final int totalEarnings;
  final int upcomingTours;
  final int pendingRequests;

  const DashboardEntity({
    required this.totalEarnings,
    required this.upcomingTours,
    required this.pendingRequests,
  });

  @override
  List<Object?> get props => [totalEarnings, upcomingTours, pendingRequests];
}

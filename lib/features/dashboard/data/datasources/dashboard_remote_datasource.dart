import 'package:flutter_clean_architecture/features/dashboard/data/models/dashboard_model.dart';
import 'dart:math';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> getDashboardStats(int guideId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<DashboardModel> getDashboardStats(int guideId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return fake randomized stats for the MVP depending on the Guide ID
    final random = Random(guideId); 
    
    return DashboardModel(
      totalEarnings: 1500 + random.nextInt(5000), // Random earnings between 1500 and 6500 MAD
      upcomingTours: 1 + random.nextInt(5),       // Random 1-5 upcoming tours
      pendingRequests: random.nextInt(4),         // Random 0-3 pending requests
    );
  }
}

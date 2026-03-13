import 'package:flutter_clean_architecture/features/dashboard/domain/entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<DashboardEntity> getDashboardStats(int guideId);
}

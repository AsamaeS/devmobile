import 'package:flutter_clean_architecture/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:flutter_clean_architecture/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardStatsUseCase {
  final DashboardRepository repository;

  GetDashboardStatsUseCase(this.repository);

  Future<DashboardEntity> call(int guideId) {
    return repository.getDashboardStats(guideId);
  }
}

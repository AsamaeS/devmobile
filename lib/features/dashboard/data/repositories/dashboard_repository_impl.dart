import 'package:flutter_clean_architecture/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:flutter_clean_architecture/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<DashboardEntity> getDashboardStats(int guideId) async {
    try {
      return await remoteDataSource.getDashboardStats(guideId);
    } catch (e) {
      throw Exception('Failed to fetch dashboard stats: $e');
    }
  }
}

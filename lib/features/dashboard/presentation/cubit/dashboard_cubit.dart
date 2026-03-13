import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import 'package:flutter_clean_architecture/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:flutter_clean_architecture/features/dashboard/domain/entities/dashboard_entity.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardStatsUseCase getDashboardStatsUseCase;

  DashboardCubit({required this.getDashboardStatsUseCase}) : super(DashboardInitial());

  Future<void> loadDashboard(int guideId) async {
    emit(DashboardLoading());
    try {
      final stats = await getDashboardStatsUseCase(guideId);
      emit(DashboardLoaded(stats));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  // Mock function to simulate accepting a booking request
  void acceptRequest() {
    if (state is DashboardLoaded) {
      final currentStats = (state as DashboardLoaded).stats;
      if (currentStats.pendingRequests > 0) {
        emit(DashboardLoading());
        // Simulate immediate UI update for MVP
        Future.delayed(const Duration(milliseconds: 300), () {
          emit(DashboardLoaded(
            DashboardEntity(
              totalEarnings: currentStats.totalEarnings,
              upcomingTours: currentStats.upcomingTours + 1,
              pendingRequests: currentStats.pendingRequests - 1,
            )
          ));
        });
      }
    }
  }
}

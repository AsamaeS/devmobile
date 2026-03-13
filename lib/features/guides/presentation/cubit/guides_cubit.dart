import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/guides/data/datasources/guides_mock_data.dart';
import 'package:flutter_clean_architecture/features/guides/domain/entities/guide_entity.dart';
import 'package:flutter_clean_architecture/features/guides/presentation/cubit/guides_state.dart';

class GuidesCubit extends Cubit<GuidesState> {
  GuidesCubit() : super(GuidesInitial());

  void fetchGuides() async {
    emit(GuidesLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      emit(const GuidesLoaded(GuidesMockData.guides));
    } catch (e) {
      emit(GuidesError(e.toString()));
    }
  }

  void searchGuides({
    String? city,
    double? minBudget,
    double? maxBudget,
    String? language,
    bool? transportAvailable,
    double? minRating,
  }) async {
    emit(GuidesLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      List<GuideEntity> filtered = GuidesMockData.guides;

      if (city != null && city.isNotEmpty && city != "All") {
        filtered = filtered.where((g) => g.city.toLowerCase() == city.toLowerCase()).toList();
      }
      
      if (minBudget != null && maxBudget != null) {
        // Find guides that overlap with the budget range
        filtered = filtered.where((g) => g.priceMin <= maxBudget && g.priceMax >= minBudget).toList();
      }

      if (language != null && language.isNotEmpty && language != "All") {
        filtered = filtered.where((g) => g.languages.contains(language)).toList();
      }

      if (transportAvailable == true) {
        filtered = filtered.where((g) => g.transportAvailable).toList();
      }

      if (minRating != null) {
        filtered = filtered.where((g) => g.rating >= minRating).toList();
      }

      emit(GuidesLoaded(filtered));
    } catch (e) {
      emit(GuidesError(e.toString()));
    }
  }
}

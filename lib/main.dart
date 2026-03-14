import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter_clean_architecture/features/guides/presentation/cubit/guides_cubit.dart';
import 'package:flutter_clean_architecture/features/auth/providers/auth_providers.dart';
import 'package:flutter_clean_architecture/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:flutter_clean_architecture/features/booking/domain/usecases/create_booking_usecase.dart';
import 'package:flutter_clean_architecture/features/booking/domain/usecases/process_payment_usecase.dart';
import 'package:flutter_clean_architecture/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:flutter_clean_architecture/features/reviews/data/datasources/review_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/reviews/data/repositories/review_repository_impl.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:flutter_clean_architecture/features/reviews/domain/usecases/get_reviews_usecase.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter_clean_architecture/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:flutter_clean_architecture/features/dashboard/domain/usecases/get_dashboard_stats_usecase.dart';
import 'package:flutter_clean_architecture/features/dashboard/presentation/cubit/dashboard_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<GuidesCubit>(create: (context) => GuidesCubit()),
        BlocProvider(
          create: (context) {
            final repo = BookingRepositoryImpl(BookingRemoteDataSourceImpl());
            return BookingCubit(
              createBookingUseCase: CreateBookingUseCase(repo),
              processPaymentUseCase: ProcessPaymentUseCase(repo),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            final repo = ReviewRepositoryImpl(ReviewRemoteDataSourceImpl());
            return ReviewsCubit(
              getReviewsUseCase: GetReviewsUseCase(repo),
              addReviewUseCase: AddReviewUseCase(repo),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            final repo = DashboardRepositoryImpl(DashboardRemoteDataSourceImpl());
            return DashboardCubit(
              getDashboardStatsUseCase: GetDashboardStatsUseCase(repo),
            );
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Tourist Guide',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}

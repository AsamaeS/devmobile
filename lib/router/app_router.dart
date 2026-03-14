import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter_clean_architecture/features/home/presentation/layout/home_layout.dart';
import 'package:flutter_clean_architecture/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_clean_architecture/features/guides/domain/entities/guide_entity.dart';
import 'package:flutter_clean_architecture/features/booking/domain/entities/booking_entity.dart';
import 'package:flutter_clean_architecture/features/guides/presentation/pages/search_guides_page.dart';
import 'package:flutter_clean_architecture/features/guides/presentation/pages/guides_list_page.dart';
import 'package:flutter_clean_architecture/features/guides/presentation/pages/guide_details_page.dart';
import 'package:flutter_clean_architecture/features/booking/presentation/pages/booking_page.dart';
import 'package:flutter_clean_architecture/features/booking/presentation/pages/payment_page.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/pages/reviews_page.dart';
import 'package:flutter_clean_architecture/features/reviews/presentation/pages/add_review_page.dart';
import 'package:flutter_clean_architecture/features/dashboard/presentation/pages/guide_dashboard_page.dart';
import 'package:flutter_clean_architecture/router/guards.dart';
import 'package:flutter_clean_architecture/router/routes.dart';
import 'package:go_router/go_router.dart';

final class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: Routes.home,
        // redirect: AuthGuard.guard,
        routes: [
          // Splash Route
          GoRoute(
            path: Routes.splash,
            builder: (context, state) => const SplashScreen(),
          ),
          // Auth Routes
          GoRoute(
            path: Routes.login,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: Routes.register,
            builder: (context, state) => const RegisterScreen(),
          ),
            // Home Routes with ShellRoute
            ShellRoute(
              builder: (context, state, child) => HomeLayout(child: child),
              routes: [
                GoRoute(
                  path: Routes.home,
                  builder: (context, state) => const HomeScreen(),
                ),
                GoRoute(
                  path: Routes.searchGuides,
                  builder: (context, state) => const SearchGuidesPage(),
                ),
                GoRoute(
                  path: Routes.guidesList,
                  builder: (context, state) => const GuidesListPage(),
                ),
                GoRoute(
                  path: Routes.guideDetails,
                  builder: (context, state) {
                    final guide = state.extra as GuideEntity;
                    return GuideDetailsPage(guide: guide);
                  },
                ),
                GoRoute(
                  path: Routes.booking,
                  builder: (context, state) {
                    final guide = state.extra as GuideEntity;
                    return BookingPage(guide: guide);
                  },
                ),
                GoRoute(
                  path: Routes.payment,
                  builder: (context, state) {
                    final booking = state.extra as BookingEntity;
                    return PaymentPage(booking: booking);
                  },
                ),
                GoRoute(
                  path: Routes.reviews,
                  builder: (context, state) {
                    final guide = state.extra as GuideEntity;
                    return ReviewsPage(guide: guide);
                  },
                ),
                GoRoute(
                  path: Routes.addReview,
                  builder: (context, state) {
                    final guide = state.extra as GuideEntity;
                    return AddReviewPage(guide: guide);
                  },
                ),
                GoRoute(
                  path: Routes.dashboard,
                  builder: (context, state) => const GuideDashboardPage(),
                ),
              ],
            ),
          ],
        );
}

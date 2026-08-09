import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/splash_view.dart';
import '../views/user_view.dart';
import 'app_routes.dart';
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      pageBuilder: (context, state) => _fadeTransitionPage(
        key: state.pageKey,
        child: const SplashView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.user,
      name: 'user',
      pageBuilder: (context, state) => _fadeTransitionPage(
        key: state.pageKey,
        child: const UserView(),
      ),
    ),

    // GoRoute(
    //   path: AppRoutes.home,
    //   name: 'home',
    //   pageBuilder: (context, state) => _fadeTransitionPage(
    //     key: state.pageKey,
    //     child: const HomeView(),
    //   ),
    // ),
  ],
);


CustomTransitionPage _fadeTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
      return FadeTransition(
        opacity: curved,
        child: child,
      );
    },
  );
}

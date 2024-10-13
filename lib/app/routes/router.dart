import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_sphere_mobile/views/screens/screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: 'leave',
          builder: (BuildContext context, GoRouterState state) {
            return const LeaveScreen();
          },
          routes: [
            GoRoute(
              path: 'request',
              builder: (BuildContext context, GoRouterState state) {
                return const LeaveRequestScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'reimburse',
          builder: (BuildContext context, GoRouterState state) {
            return const ReimbursementScreen();
          },
          routes: [
            GoRoute(
              path: 'request',
              builder: (BuildContext context, GoRouterState state) {
                return const ReimbursementRequestScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

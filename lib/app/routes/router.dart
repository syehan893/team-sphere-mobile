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
        ),
        GoRoute(
          path: 'reimbursement',
          builder: (BuildContext context, GoRouterState state) {
            return const ReimbursementScreen();
          },
        ),
      ],
    ),
  ],
);

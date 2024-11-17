import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_sphere_mobile/views/screens/news/news_detail_screen.dart';
import 'package:team_sphere_mobile/views/screens/screen.dart';

import '../../views/screens/profile/privacy_and_policy.dart';
import '../../views/screens/profile/term_and_condition.dart';

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
              return LeaveScreen();
            },
            routes: [
              GoRoute(
                path: 'request',
                builder: (BuildContext context, GoRouterState state) {
                  return const LeaveRequestScreen();
                },
              ),
            ]),
        GoRoute(
          path: 'reimburse',
          builder: (BuildContext context, GoRouterState state) {
            return ReimbursementScreen();
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
        GoRoute(
          path: 'news',
          builder: (BuildContext context, GoRouterState state) {
            return const NewsDetailScreen();
          },
          routes: [
            GoRoute(
              path: 'detail',
              builder: (BuildContext context, GoRouterState state) {
                return const ReimbursementRequestScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'terms',
          builder: (BuildContext context, GoRouterState state) {
            return const TermsAndConditionScreen();
          },
        ),
        GoRoute(
          path: 'policy',
          builder: (BuildContext context, GoRouterState state) {
            return const PrivacyAndPolicyScreen();
          },
        ),
      ],
    ),
  ],
);

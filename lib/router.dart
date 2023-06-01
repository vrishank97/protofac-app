import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protofac/screens/home.dart';
import 'package:protofac/screens/home_screen.dart';
import 'package:protofac/screens/leaderboard_screen.dart';
import 'package:protofac/screens/profile_screen.dart';
import 'package:protofac/screens/signin_screen.dart';
import 'package:protofac/screens/workflowform_screen.dart';
import 'package:protofac/services/auth_service.dart';

import 'locator.dart';

final GoRouter gorouter = GoRouter(
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => const SignInScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HomeScaffoldWithNavbar(child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/leaderboard',
            builder: (context, state) => const LeaderboardScreen(),
          ),
          GoRoute(
            path: '/buildworkflow',
            builder: (context, state) => WorkflowFormScreen(),
          ),
        ],
      )
    ],
    redirect: (BuildContext context, GoRouterState state) {
      var auth = getIt<AuthService>();
      final isAuthenticated = auth.getLogin();
      if (!isAuthenticated) {
        return '/login';
      } else {
        return null; // return "null" to display the intended route without redirecting
      }
    });

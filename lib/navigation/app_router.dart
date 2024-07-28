import 'dart:async';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../core/pages/page_not_found.dart';
import '../features/auth/presentation/bloc/auth/auth_bloc.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/update_user_page.dart';
import '../features/home/home_page.dart';



class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'authentication',
        builder: (context, state) {
          return AuthPage();
        },
        routes: [
          GoRoute(
            path: 'register',
            name: 'register',
            builder: (context, state) {
              return RegisterPage();
            },
          ),
          GoRoute(
            path: 'login',
            name: 'login',
            builder: (context, state) {
              return LoginPage();
            },
          ),
          GoRoute(
            path: 'update',
            name: 'update_user',
            builder: (context, state) {
              return UpdateUserPage();
            },
          ),
        ],
      ),
      GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) {
            return HomePage();
          }),
    ],
    errorBuilder: (context, state) => PageNotFound(),
    redirect: (context, state) {
      final bool unauthenticated = authBloc.state is UnAuthenticatedState;
      final bool authenticated = authBloc.state is AuthenticatedState;

      final bool isThoughtsPage = (state.subloc == '/home');
      final bool isAuthOrLoginOrRegister = ((state.subloc == '/') ||
          (state.subloc == '/register') ||
          (state.subloc == '/login'));

      if (unauthenticated) {
        return isThoughtsPage ? '/' : null;
      }

      if (authenticated) {
        return isAuthOrLoginOrRegister ? '/home' : null;
      }
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

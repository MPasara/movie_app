// ignore_for_file: always_use_package_imports
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../../common/domain/providers/base_router_provider.dart';
import '../../../home/presentation/home_page.dart';
import '../../../login/presentation/login_page.dart';
import '../../data/repository/auth_repository.dart';
import 'auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier()..checkIfAuthenticated(),
);

class AuthNotifier extends Notifier<AuthState> implements Listenable {
  late AuthRepository _authRepository;
  VoidCallback? _routerListener;
  String? _deepLink;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const AuthState.initial();
  }

  Future<void> checkIfAuthenticated() async {
    await 100.milliseconds;
    ref.read(globalLoadingProvider.notifier).update((_) => true);
    final result = await _authRepository.getTokenIfAuthenticated();
    result.fold(
      (failure) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        ref.read(globalFailureProvider.notifier).update((_) => failure);
        state = const AuthState.unauthenticated();
        _routerListener?.call();
      },
      (token) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        state = token != null
            ? const AuthState.authenticated()
            : const AuthState.unauthenticated();
        _routerListener?.call();
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    ref.read(globalLoadingProvider.notifier).update((_) => true);
    state = const AuthState.authenticating();
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        ref.read(globalFailureProvider.notifier).update((_) => failure);
        state = const AuthState.unauthenticated();
        _routerListener?.call();
      },
      (response) {
        ref.read(globalLoadingProvider.notifier).update((_) => false);
        state = const AuthState.authenticated();
        _routerListener?.call();
      },
    );
  }

  Future<void> logout() async {
    await 500.milliseconds;
    state = const AuthState.unauthenticated();
    _routerListener?.call();
  }

  String? redirect({
    required GoRouterState goRouterState,
    required bool showErrorIfNonExistentRoute,
  }) {
    final isAuthenticating = switch (state) {
      AuthStateInitial() || AuthStateAuthenticating() => true,
      _ => false,
    };
    if (isAuthenticating) return null;
    final isLoggedIn =
        switch (state) { AuthStateAuthenticated() => true, _ => false };
    final loggingIn = goRouterState.matchedLocation == LoginPage.routeName;
    if (loggingIn) {
      if (isLoggedIn) {
        if (_deepLink != null) {
          final tmpDeepLink = _deepLink;
          _deepLink = null;
          return tmpDeepLink;
        }
        return HomePage.routeName;
      }
      return null;
    }

    final routeExists =
        ref.read(baseRouterProvider).routeExists(goRouterState.matchedLocation);
    final loginRoutes =
        goRouterState.matchedLocation.startsWith(LoginPage.routeName);
    if (isLoggedIn && routeExists) {
      return loginRoutes ? HomePage.routeName : null;
    }
    _deepLink =
        !loginRoutes && routeExists ? goRouterState.uri.toString() : null;
    return loginRoutes || (showErrorIfNonExistentRoute && !routeExists)
        ? null
        : LoginPage.routeName;
  }

  @override
  void addListener(VoidCallback listener) => _routerListener = listener;

  @override
  void removeListener(VoidCallback listener) => _routerListener = null;
}

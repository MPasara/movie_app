// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/spacing.dart';
import '../../auth/domain/notifiers/auth_notifier.dart';
import '../../register/presentation/register_page.dart';
import '../../reset_password/presentation/reset_password_page.dart';

class LoginPage extends ConsumerWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: context.appColors.background,
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () => ref
                .read(authNotifierProvider.notifier)
                .login(email: 'email', password: 'password'),
            child: const Text('Login'),
          ),
          spacing16,
          TextButton(
            onPressed: () =>
                ref.pushNamed('$routeName${ResetPasswordPage.routeName}'),
            child: const Text('Reset Password'),
          ),
          spacing16,
          TextButton(
            onPressed: () =>
                ref.pushNamed('$routeName${RegisterPage.routeName}'),
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/widgets/app_drawer.dart';
import 'package:movie_app/common/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/generated/l10n.dart';

class PopularMoviesPage extends ConsumerWidget {
  static const routeName = '/popular-movies';

  PopularMoviesPage({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: _globalKey,
      drawer: const AppDrawer(),
      appBar: MovieAppBar(globalKey: _globalKey),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 28),
            child: Row(
              children: [
                Text(
                  S.of(context).popular,
                  style: context.appTextStyles.bold!.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    /* ListView(
      children: [
        Text(
          'Dashboard',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        spacing16,
        TextButton(
          onPressed: ref.read(authNotifierProvider.notifier).logout,
          child: Text(
            'Logout',
            style: context.appTextStyles.regular,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(ExamplePage.routeName),
          ),
          child: Text(
            'Go to example page',
            style: context.appTextStyles.bold,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              UserDetailsPage.getRouteNameWithParams(1),
            ),
          ),
          child: Text(
            'Dashboard -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            '${UsersPage.routeName}${UserDetailsPage.getRouteNameWithParams(1)}',
          ),
          child: Text(
            'Users -> User details 1',
            style: context.appTextStyles.bold,
          ),
        ),
        if (!EnvInfo.isProduction) ...[
          spacing16,
          TextButton(
            onPressed: () => QLogger.showLogger(
              ref.read(baseRouterProvider).navigatorContext!,
            ),
            child: Text('Show log report', style: context.appTextStyles.bold),
          ),
        ],
      ],
    ); */
  }
}

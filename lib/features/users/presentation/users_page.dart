// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/widgets/app_drawer.dart';
import 'package:movie_app/common/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/generated/l10n.dart';

class UsersPage extends ConsumerWidget {
  static const routeName = '/users';

  UsersPage({super.key});
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
                  S.of(context).favourites,
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
          'Users',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              UserDetailsPage.getRouteNameWithParams(1, optional: 'abc'),
            ),
          ),
          child: Text(
            'User 1',
            style: context.appTextStyles.bold,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              UserDetailsPage.getRouteNameWithParams(2),
              keepExistingQueryString: false,
            ),
          ),
          child: Text(
            'User 2',
            style: context.appTextStyles.bold,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            '${UsersPage.routeName}${UserDetailsPage.routeName.replaceAll(UserDetailsPage.pathPattern, 'R')}',
          ),
          child: Text(
            'User R',
            style: context.appTextStyles.bold,
          ),
        ),
      ],
    ); */
  }
}

// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/widgets/app_drawer.dart';
import 'package:movie_app/common/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/features/favourite/domain/notifiers/favourite_movies_notifier.dart';
import 'package:movie_app/generated/l10n.dart';

class FavouriteMoviePage extends ConsumerWidget {
  static const routeName = '/users';

  FavouriteMoviePage({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMovies = ref.watch(favouriteMoviesProvider);

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
          ListView.builder(
            itemCount: favouriteMovies.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movieId = favouriteMovies.keys.elementAt(
                index,
              );
              return ListTile(
                title: Text(
                  'Movie ID: $movieId',
                  style: TextStyle(color: context.appColors.defaultColor),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/widgets/app_drawer.dart';
import 'package:movie_app/common/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/features/favourite/domain/notifiers/favourite_movies_notifier.dart';
import 'package:movie_app/features/popular/presentation/widgets/popular_movie_list_tile.dart';
import 'package:movie_app/generated/l10n.dart';

class FavouriteMoviePage extends ConsumerStatefulWidget {
  static const routeName = '/users';

  const FavouriteMoviePage({super.key});

  @override
  ConsumerState<FavouriteMoviePage> createState() => _FavouriteMoviePageState();
}

class _FavouriteMoviePageState extends ConsumerState<FavouriteMoviePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMovies = ref.watch(favouriteMoviesNotifierProvider);

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
                  style: context.appTextStyles.pageHeading,
                ),
              ],
            ),
          ),
          favouriteMovies.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      S.of(context).no_favourite_movies,
                      style: context.appTextStyles.movieCardTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Expanded(
                  child: RawScrollbar(
                    padding: const EdgeInsets.only(right: 4),
                    thumbColor:
                        context.appColors.defaultColor!.withValues(alpha: 0.8),
                    controller: _scrollController,
                    thickness: 3,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: favouriteMovies.length,
                      itemBuilder: (context, index) {
                        // Get the current movie from the map or list
                        final movie = favouriteMovies.values.elementAt(index);
                        return PopularMovieListTile(movie: movie);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

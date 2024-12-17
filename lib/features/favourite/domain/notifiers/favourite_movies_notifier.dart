import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/features/favourite/data/repositories/database_repository.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:q_architecture/q_architecture.dart';

final favouriteMoviesNotifierProvider =
    NotifierProvider<FavouriteMoviesNotifier, Map<int, Movie>>(
  FavouriteMoviesNotifier.new,
  name: 'Favourite movies notifier provider',
);

class FavouriteMoviesNotifier extends SimpleNotifier<Map<int, Movie>> {
  late FavouriteMoviesRepository _favouriteMoviesRepository;

  @override
  Map<int, Movie> prepareForBuild() {
    _favouriteMoviesRepository = ref.watch(favouriteMoviesRepositoryProvider);
    loadFavourites();
    return {};
  }

  Future<void> toggleFavourite(Movie movie) async {
    throttle(
      () async {
        if (state.containsKey(movie.id)) {
          final eitherFailureOrUnfavourite =
              await _favouriteMoviesRepository.unfavouriteMovie(movie.id);
          eitherFailureOrUnfavourite.fold(
            (failure) {
              Fluttertoast.showToast(
                msg: failure.title,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.redAccent,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 16,
              );
            },
            (_) {
              state = {...state}..remove(movie.id);
            },
          );
        } else {
          final eitherFailureOrFavourite =
              await _favouriteMoviesRepository.favouriteMovie(movie);
          eitherFailureOrFavourite.fold(
            (failure) {
              Fluttertoast.showToast(
                msg: failure.title,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.redAccent,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 16,
              );
            },
            (_) {
              Fluttertoast.showToast(
                textColor: Colors.black,
                msg: 'Movie added to favourites',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.greenAccent,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 16,
              );
              state = {...state}..putIfAbsent(movie.id, () => movie);
            },
          );
        }
      },
    );
  }

  Future<void> loadFavourites() async {
    final eitherFailureOrFavouriteMovies =
        await _favouriteMoviesRepository.loadFavouriteMovies();

    eitherFailureOrFavouriteMovies.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: failure.title,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.redAccent,
          gravity: ToastGravity.SNACKBAR,
          fontSize: 16,
        );
      },
      (favMovies) {
        final favouriteMoviesMap = Map<int, Movie>.fromEntries(
          favMovies.map((movie) => MapEntry(movie.id, movie)),
        );

        state = favouriteMoviesMap;
      },
    );
  }
}

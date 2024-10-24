// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/widgets/app_drawer.dart';
import 'package:movie_app/common/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/features/popular/domain/notifiers/popular_movies_notifier.dart';
import 'package:movie_app/features/popular/presentation/widgets/popular_movies_list_widget.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';

class PopularMoviesPage extends ConsumerWidget {
  static const routeName = '/popular-movies';

  PopularMoviesPage({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(popularMoviesNotifierProvider);

    return Scaffold(
      key: _globalKey,
      drawer: const AppDrawer(),
      appBar: MovieAppBar(globalKey: _globalKey),
      body: switch (state) {
        BaseInitial() => const SizedBox(),
        BaseLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        BaseError(failure: final failure) => Center(
            child: Text(
              failure.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        BaseData(data: final movies) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28, bottom: 20, left: 20),
                child: Row(
                  children: [
                    Text(
                      S.of(context).popular,
                      style: context.appTextStyles.bold!.copyWith(fontSize: 22),
                    ),
                  ],
                ),
              ),
              PopularMoviesListWidget(movies: movies),
            ],
          ),
      },
    );
  }
}

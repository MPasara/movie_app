// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/spacing.dart';
import 'package:movie_app/common/presentation/widgets/app_drawer.dart';
import 'package:movie_app/common/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/features/popular/domain/notifiers/popular_movies_notifier.dart';
import 'package:movie_app/features/popular/presentation/widgets/popular_movies_list_widget.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:q_architecture/base_notifier.dart';

class PopularMoviesPage extends ConsumerStatefulWidget {
  static const routeName = '/popular-movies';

  const PopularMoviesPage({super.key});

  @override
  ConsumerState<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends ConsumerState<PopularMoviesPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(popularMoviesNotifierProvider.notifier).loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(popularMoviesNotifierProvider);

    return Scaffold(
      key: _globalKey,
      drawer: const AppDrawer(),
      appBar: MovieAppBar(globalKey: _globalKey),
      body: switch (state) {
        BaseInitial() => const SizedBox(),
        BaseLoading() => const Center(child: CircularProgressIndicator()),
        BaseError(failure: final failure) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  failure.title,
                  style: TextStyle(color: context.appColors.defaultColor),
                ),
              ),
              spacing14,
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(popularMoviesNotifierProvider.notifier)
                      .getPopularMovies(1);
                },
                child: Text(
                  S.of(context).try_again,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        BaseData(data: final movieWrapper) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28, bottom: 4, left: 20),
                child: Row(
                  children: [
                    Text(
                      S.of(context).popular,
                      style: context.appTextStyles.pageHeading,
                    ),
                  ],
                ),
              ),
              PopularMoviesListWidget(
                movies: movieWrapper.movies,
                scrollController: _scrollController,
              ),
            ],
          ),
      },
    );
  }
}

// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/widgets/app_drawer.dart';
import 'package:movie_app/common/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/features/popular/domain/notifiers/popular_movies_notifier.dart';
import 'package:movie_app/features/popular/domain/providers/current_page_provider.dart';
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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final currentPage = ref.read(currentPageProvider.notifier).state + 1;

      ref
          .read(popularMoviesNotifierProvider.notifier)
          .getPopularMovies(currentPage);
      ref.read(currentPageProvider.notifier).state = currentPage;
      return;
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
        BaseError(failure: final failure) => Center(
            child: Text(
              failure.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        BaseData(data: final movies) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28, bottom: 4, left: 20),
                child: Row(
                  children: [
                    Text(
                      S.of(context).popular,
                      style: context.appTextStyles.bold!.copyWith(fontSize: 22),
                    ),
                  ],
                ),
              ),
              PopularMoviesListWidget(
                movies: movies,
                scrollController: _scrollController,
              ),
            ],
          ),
      },
    );
  }
}

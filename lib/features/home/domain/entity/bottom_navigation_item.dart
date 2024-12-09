// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:movie_app/generated/l10n.dart';

import '../../../popular/presentation/popular_movies_page.dart';
import '../../../favourite/presentation/pages/favourite_movies_page.dart';

enum BottomNavigationItem {
  /* dashboard(icon: Icons.home, routeName: DashboardPage.routeName),
  users(icon: Icons.account_circle, routeName: UsersPage.routeName),
  notifications(icon: Icons.add_alert, routeName: NotificationsPage.routeName),
  directories(icon: Icons.folder, routeName: DirectoriesPage.routeName), */
  movies(
    icon: Icons.movie_creation_outlined,
    routeName: PopularMoviesPage.routeName,
  ),
  favourites(
      icon: Icons.bookmark_border, routeName: FavouriteMoviePage.routeName,);

  final IconData icon;
  final String routeName;

  const BottomNavigationItem({required this.icon, required this.routeName});

  String get title => switch (this) {
        movies => S.current.movies,
        favourites => S.current.favourites,
        /* notifications => 'Notifications',
        directories => 'Directories', */
      };

  static int getIndexForLocation(String? location) =>
      BottomNavigationItem.values
          .firstWhere(
            (element) => location?.startsWith(element.routeName) == true,
            orElse: () => BottomNavigationItem.movies,
          )
          .index;
}

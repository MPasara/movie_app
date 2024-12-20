// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';
import 'package:movie_app/features/popular/presentation/movie_details_page.dart';

import '../../../common/domain/utils/string_extension.dart';
import '../../../example/example_routes.dart';
import '../../../features/directories/presentation/directories_page.dart';
import '../../../features/favourite/presentation/pages/favourite_movies_page.dart';
import '../../../features/home/presentation/home_page.dart';
import '../../../features/login/presentation/login_page.dart';
import '../../../features/notifications/presentation/all_notifications_page.dart';
import '../../../features/notifications/presentation/notification_details_page.dart';
import '../../../features/notifications/presentation/notifications_page.dart';
import '../../../features/popular/presentation/popular_movies_page.dart';
import '../../../features/register/presentation/register_page.dart';
import '../../../features/reset_password/presentation/reset_password_page.dart';
import '../../../features/users/presentation/user_details_page.dart';
import 'go_router_state_extension.dart';

List<RouteBase> getRoutes({
  required GlobalKey<NavigatorState> rootNavigatorKey,
  bool stateful = true,
}) =>
    [
      GoRoute(
        path: HomePage.routeName,
        redirect: (context, state) => PopularMoviesPage.routeName,
      ),
      if (stateful)
        _statefulShellRoute(rootNavigatorKey: rootNavigatorKey)
      else
        _shellRoute(rootNavigatorKey: rootNavigatorKey),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: ResetPasswordPage.routeName.lastPart,
            builder: (context, state) => const ResetPasswordPage(),
          ),
          GoRoute(
            path: RegisterPage.routeName.lastPart,
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
    ];

RouteBase _statefulShellRoute({
  required GlobalKey<NavigatorState> rootNavigatorKey,
}) =>
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomePage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PopularMoviesPage.routeName,
              builder: (context, state) => const PopularMoviesPage(),
              routes: [
                GoRoute(
                  path: MovieDetailsPage.routeName.removeLeadingSlash,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) {
                    final movie = state.extra as Movie;
                    return MovieDetailsPage(movie: movie);
                  },
                ),
                GoRoute(
                  path: UserDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => UserDetailsPage(
                    userId: state.getPathParameterByName<int>(
                      name: UserDetailsPage.pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        UserDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: PopularMoviesPage.routeName,
                  ),
                ),
                getExampleRoutes(rootNavigatorKey: rootNavigatorKey),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: FavouriteMoviePage.routeName,
              builder: (context, state) => const FavouriteMoviePage(),
              routes: [
                GoRoute(
                  path: MovieDetailsPage.routeName.removeLeadingSlash,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) {
                    final movie = state.extra as Movie;
                    return MovieDetailsPage(movie: movie);
                  },
                ),
                GoRoute(
                  path: UserDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => UserDetailsPage(
                    userId: state.getPathParameterByName<int>(
                      name: UserDetailsPage.pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        UserDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: FavouriteMoviePage.routeName,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NotificationsPage.routeName,
              builder: (context, state) => const NotificationsPage(),
              routes: [
                GoRoute(
                  path: AllNotificationsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => const AllNotificationsPage(),
                  routes: [
                    GoRoute(
                      path:
                          NotificationDetailsPage.routeName.removeLeadingSlash,
                      builder: (context, state) => NotificationDetailsPage(
                        notificationId: state.getPathParameterByName<int>(
                          name: NotificationDetailsPage
                              .pathPattern.removeLeadingColon,
                        )!,
                      ),
                      redirect: (context, state) =>
                          state.redirectIfPathParameterValid<int>(
                        pathParameterName: NotificationDetailsPage
                            .pathPattern.removeLeadingColon,
                        redirectTo:
                            '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: NotificationDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => NotificationDetailsPage(
                    notificationId: state.getPathParameterByName<int>(
                      name: NotificationDetailsPage
                          .pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        NotificationDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo: NotificationsPage.routeName,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: DirectoriesPage.routeName,
              builder: (context, state) => const DirectoriesPage(),
              routes: [
                _buildRoutesRecursively(
                  depth: 10,
                  pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
                  builderCallback: (context, state, depth) => DirectoriesPage(
                    directoryName: state.pathParameters[
                        DirectoriesPage.pathPattern(depth).removeLeadingColon],
                    canGoDeeper: depth > 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );

RouteBase _shellRoute({required GlobalKey<NavigatorState> rootNavigatorKey}) =>
    ShellRoute(
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
          path: PopularMoviesPage.routeName,
          builder: (context, state) => const PopularMoviesPage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => UserDetailsPage(
                userId: state.getPathParameterByName(
                  name: UserDetailsPage.pathPattern.removeLeadingColon,
                )!,
              ),
              redirect: (context, state) =>
                  state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    UserDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: PopularMoviesPage.routeName,
              ),
            ),
          ],
        ),
        GoRoute(
          path: FavouriteMoviePage.routeName,
          builder: (context, state) => const FavouriteMoviePage(),
          routes: [
            GoRoute(
              path: UserDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => UserDetailsPage(
                userId: state.getPathParameterByName(
                  name: UserDetailsPage.pathPattern.removeLeadingColon,
                )!,
              ),
              redirect: (context, state) =>
                  state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    UserDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: FavouriteMoviePage.routeName,
              ),
            ),
          ],
        ),
        GoRoute(
          path: NotificationsPage.routeName,
          builder: (context, state) => const NotificationsPage(),
          routes: [
            GoRoute(
              path: AllNotificationsPage.routeName.removeLeadingSlash,
              builder: (context, state) => const AllNotificationsPage(),
              routes: [
                GoRoute(
                  path: NotificationDetailsPage.routeName.removeLeadingSlash,
                  builder: (context, state) => NotificationDetailsPage(
                    notificationId: state.getPathParameterByName<int>(
                      name: NotificationDetailsPage
                          .pathPattern.removeLeadingColon,
                    )!,
                  ),
                  redirect: (context, state) =>
                      state.redirectIfPathParameterValid<int>(
                    pathParameterName:
                        NotificationDetailsPage.pathPattern.removeLeadingColon,
                    redirectTo:
                        '${NotificationsPage.routeName}${AllNotificationsPage.routeName}',
                  ),
                ),
              ],
            ),
            GoRoute(
              path: NotificationDetailsPage.routeName.removeLeadingSlash,
              builder: (context, state) => NotificationDetailsPage(
                notificationId: state.getPathParameterByName<int>(
                  name: NotificationDetailsPage.pathPattern.removeLeadingColon,
                )!,
              ),
              redirect: (context, state) =>
                  state.redirectIfPathParameterValid<int>(
                pathParameterName:
                    NotificationDetailsPage.pathPattern.removeLeadingColon,
                redirectTo: NotificationsPage.routeName,
              ),
            ),
          ],
        ),
        GoRoute(
          path: DirectoriesPage.routeName,
          builder: (context, state) => const DirectoriesPage(),
          routes: [
            _buildRoutesRecursively(
              depth: 10,
              pathCallback: (depth) => DirectoriesPage.pathPattern(depth),
              builderCallback: (context, state, depth) => DirectoriesPage(
                directoryName: state.pathParameters[
                    DirectoriesPage.pathPattern(depth).removeLeadingColon],
                canGoDeeper: depth > 1,
              ),
            ),
          ],
        ),
      ],
    );

GoRoute _buildRoutesRecursively({
  required int depth,
  required Function(int depth) pathCallback,
  Page Function(BuildContext context, GoRouterState state, int depth)?
      pageBuilderCallback,
  Widget Function(BuildContext context, GoRouterState state, int depth)?
      builderCallback,
  GlobalKey<NavigatorState>? parentNavigatorKey,
}) {
  assert(pageBuilderCallback != null || builderCallback != null);
  return GoRoute(
    parentNavigatorKey: parentNavigatorKey,
    path: pathCallback(depth),
    pageBuilder: pageBuilderCallback != null
        ? (context, state) => pageBuilderCallback(context, state, depth)
        : null,
    builder: builderCallback != null
        ? (context, state) => builderCallback(context, state, depth)
        : null,
    routes: depth == 1
        ? <RouteBase>[]
        : [
            _buildRoutesRecursively(
              depth: depth - 1,
              pathCallback: pathCallback,
              pageBuilderCallback: pageBuilderCallback,
              builderCallback: builderCallback,
              parentNavigatorKey: parentNavigatorKey,
            ),
          ],
  );
}

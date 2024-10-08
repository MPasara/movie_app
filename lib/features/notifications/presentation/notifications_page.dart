// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/build_context_extensions.dart';
import '../../../common/presentation/spacing.dart';
import '../../popular/presentation/popular_movies_page.dart';
import 'all_notifications_page.dart';
import 'notification_details_page.dart';

class NotificationsPage extends ConsumerWidget {
  static const routeName = '/notifications';

  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Text(
          'Notifications',
          style: context.appTextStyles.boldLarge,
          textAlign: TextAlign.center,
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(PopularMoviesPage.routeName),
          child: Text(
            'Go to dashboard',
            style: context.appTextStyles.regular,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              NotificationDetailsPage.getRouteNameWithParams(1),
            ),
          ),
          child: Text(
            'Notification details 1',
            style: context.appTextStyles.regular,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(
              NotificationDetailsPage.getRouteNameWithParams(2),
            ),
          ),
          child: Text(
            'Notification details 2',
            style: context.appTextStyles.regular,
          ),
        ),
        spacing16,
        TextButton(
          onPressed: () => ref.pushNamed(
            ref.getRouteNameFromCurrentLocation(AllNotificationsPage.routeName),
          ),
          child: Text(
            'All notifications',
            style: context.appTextStyles.regular,
          ),
        ),
      ],
    );
  }
}

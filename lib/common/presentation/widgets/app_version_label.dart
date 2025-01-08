import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/domain/notifiers/app_info_notifier.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/generated/l10n.dart';
import 'package:movie_app/main/app_environment.dart';
import 'package:q_architecture/base_notifier.dart';

class AppVersionLabel extends ConsumerWidget {
  const AppVersionLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appInfoNotifierProvider);
    return switch (state) {
      BaseInitial() => const SizedBox(),
      BaseLoading() => const CircularProgressIndicator(),
      BaseData(data: final appInfo) => Text(
          '${S.of(context).version} ${appInfo.version}-${appInfo.buildNumber} ${!EnvInfo.isProduction ? '(${EnvInfo.envName.toUpperCase()})' : ''}',
          style: context.appTextStyles.movieRating,
        ),
      BaseError(failure: final failure) => Text(failure.title),
    };
  }
}

// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:movie_app/common/domain/providers/failure_provider.dart';
import 'package:movie_app/common/domain/providers/success_provider.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:q_architecture/q_architecture.dart';

import '../domain/providers/base_router_provider.dart';
import '../domain/providers/global_navigation_provider.dart';
import '../domain/router/route_action.dart';

class AppBaseWidget extends ConsumerStatefulWidget {
  final Widget child;

  const AppBaseWidget(this.child, {super.key});

  @override
  ConsumerState createState() => _AppBaseWidgetState();
}

class _AppBaseWidgetState extends ConsumerState<AppBaseWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(appTrackingTransparencyChannelProvider).requestTracking();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if you need context to showDialog or bottomSheet, use BaseRouter's navigatorContext because main context
    // won't work as BaseWidget is the first widget in builder method of MaterialApp.router so Navigator is not ready yet.
    // Be careful not to use it directly in build method (it is not ready yet), but in button callback or within
    // WidgetsBinding.instance.addPostFrameCallback.
    // final navigatorContext = ref.read(baseRouterProvider).navigatorContext;
    ref.globalNavigationListener();
    ref.listen<Failure?>(failureProvider, (_, failure) {
      if (failure == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Fluttertoast.showToast(
          msg: failure.title,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: context.appColors.errorRed,
          gravity: ToastGravity.SNACKBAR,
          fontSize: 16,
        );
      });
    });
    ref.listen(successProvider, (_, message) {
      if (message == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Fluttertoast.showToast(
          textColor: Colors.black,
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: context.appColors.successGreen,
          gravity: ToastGravity.SNACKBAR,
          fontSize: 16,
        );
      });
    });
    return BaseWidget(
      onGlobalFailure: onGlobalFailure,
      onGlobalInfo: onGlobalInfo,
      child: widget.child,
    );
  }

  void onGlobalFailure(Failure failure) {
    logError('''
        showing ${failure.isCritical ? '' : 'non-'}critical failure with 
        title ${failure.title}, 
        error: ${failure.error},
        stackTrace: ${failure.stackTrace}
      ''');
  }

  void onGlobalInfo(GlobalInfo globalInfo) {
    logInfo('''
        globalInfoStatus: ${globalInfo.globalInfoStatus}
        title: ${globalInfo.title}, 
        message: ${globalInfo.message},
      ''');
  }
}

extension _WidgetRefExtensions on WidgetRef {
  void globalNavigationListener() {
    listen<RouteAction?>(
      globalNavigationProvider,
      (_, state) => state?.execute(read(baseRouterProvider)),
    );
  }
}

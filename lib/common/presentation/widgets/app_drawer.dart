import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';
import 'package:movie_app/common/presentation/spacing.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
      child: Drawer(
        width: 250,
        backgroundColor: context.appColors.background,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.pink,
              width: 40,
              height: 40,
            ),
            spacing8,
            Container(
              color: Colors.pink,
              width: 40,
              height: 40,
            ),
            spacing8,
            Container(
              color: Colors.pink,
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

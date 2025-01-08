import 'package:flutter/material.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';

class DrawerSectionHeader extends StatelessWidget {
  const DrawerSectionHeader({
    super.key,
    required this.header,
  });

  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Text(
            header,
            style: context.appTextStyles.movieCardTitle,
          ),
        ],
      ),
    );
  }
}

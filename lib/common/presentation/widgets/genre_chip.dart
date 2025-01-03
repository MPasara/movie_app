import 'package:flutter/material.dart';
import 'package:movie_app/common/presentation/build_context_extensions.dart';

class GenreChip extends StatelessWidget {
  final String name;
  const GenreChip({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.genreTagBackground!.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          name,
          style: context.appTextStyles.genreName,
        ),
      ),
    );
  }
}

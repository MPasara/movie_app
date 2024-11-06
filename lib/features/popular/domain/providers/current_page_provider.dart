import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentPageProvider = StateProvider<int>(
  (ref) => 1,
  name: 'Current page provider',
);

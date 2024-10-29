import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app/common/data/genre_response.dart';

final allGenresProvider = Provider<List<GenreResponse>>(
  (ref) => [],
);

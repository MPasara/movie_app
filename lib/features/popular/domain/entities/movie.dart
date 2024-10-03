import 'package:equatable/equatable.dart';
import 'package:movie_app/common/data/genre_response.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String description;
  final String posterImagePath;
  final String backdropImagePath;
  final double voteAverage;
  final bool isFavourite;
  final List<GenreResponse> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterImagePath,
    required this.backdropImagePath,
    required this.voteAverage,
    this.isFavourite = false,
    required this.genres,
  });

  Movie copyWith({
    String? id,
    String? title,
    String? description,
    String? posterImagePath,
    String? backdropImagePath,
    double? voteAverage,
    bool? isFavourite,
    List<GenreResponse>? genres,
  }) =>
      Movie(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        posterImagePath: posterImagePath ?? this.posterImagePath,
        backdropImagePath: backdropImagePath ?? this.backdropImagePath,
        voteAverage: voteAverage ?? this.voteAverage,
        isFavourite: isFavourite ?? this.isFavourite,
        genres: genres ?? this.genres,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        posterImagePath,
        backdropImagePath,
        voteAverage,
        isFavourite,
        genres,
      ];
}

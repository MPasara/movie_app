import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie { //MovieResponse
  final bool adult;

  final String backdropPath;

  final List<int> genreIds;

  final int id;

  final String originalLanguage;

  final String originalTitle;

  final String overview;
  final double popularity;

  final String posterPath;

  final String releaseDate;

  final String title;
  final bool video;

  final double voteAverage;

  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class MovieResponse { //MovieResponseWrapper
  final int page;
  final List<Movie> results;
  final int totalResults;
  final int totalPages;

  MovieResponse({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

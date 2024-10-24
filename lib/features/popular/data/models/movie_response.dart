import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieResponse {
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

  MovieResponse({
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

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieResponseWrapper {
  final int page;
  final List<MovieResponse> results;
  final int totalResults;
  final int totalPages;

  MovieResponseWrapper({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  factory MovieResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseWrapperToJson(this);
}

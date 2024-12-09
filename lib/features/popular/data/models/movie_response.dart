import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieResponse {
  final bool? adult;

  final String? backdropPath;

  final List<int> genreIds;

  final int id;

  final String? originalLanguage;

  final String? originalTitle;

  final String overview;
  final double? popularity;

  final String posterPath;

  final String? releaseDate;

  final String title;
  final bool? video;

  final double voteAverage;

  final int? voteCount;

  MovieResponse({
     this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    this.video,
    required this.voteAverage,
    this.voteCount,
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

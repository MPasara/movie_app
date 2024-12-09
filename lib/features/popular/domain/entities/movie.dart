import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String description;
  final String posterImagePath;
  final String? backdropImagePath;
  final double voteAverage;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterImagePath,
    required this.backdropImagePath,
    required this.voteAverage,
    required this.genres,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? description,
    String? posterImagePath,
    String? backdropImagePath,
    double? voteAverage,
    List<String>? genres,
  }) =>
      Movie(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        posterImagePath: posterImagePath ?? this.posterImagePath,
        backdropImagePath: backdropImagePath ?? this.backdropImagePath,
        voteAverage: voteAverage ?? this.voteAverage,
        genres: genres ?? this.genres,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'posterImagePath': posterImagePath,
      'backdropImagePath': backdropImagePath,
      'voteAverage': voteAverage,
      'genres': genres,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      posterImagePath: json['posterImagePath'],
      backdropImagePath: json['backdropImagePath'],
      voteAverage: json['voteAverage'],
      genres: List<String>.from(json['genres']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        posterImagePath,
        backdropImagePath,
        voteAverage,
        genres,
      ];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_response.g.dart';

@JsonSerializable()
class GenreResponseWrapper {
  final List<GenreResponse> genres;

  GenreResponseWrapper({required this.genres});

  factory GenreResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseWrapperToJson(this);

  @override
  bool operator ==(covariant GenreResponseWrapper other) {
    if (identical(this, other)) return true;

    return listEquals(other.genres, genres);
  }

  @override
  int get hashCode => genres.hashCode;
}

@JsonSerializable()
class GenreResponse {
  final int id;
  final String name;

  GenreResponse({
    required this.id,
    required this.name,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseToJson(this);

  @override
  bool operator ==(covariant GenreResponse other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

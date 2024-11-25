import 'package:json_annotation/json_annotation.dart';

part 'genre_response.g.dart';

@JsonSerializable()
class GenreResponseWrapper {
  final List<GenreResponse> genres;

  GenreResponseWrapper({required this.genres});

  factory GenreResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseWrapperToJson(this);
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
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreResponseWrapper _$GenreResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    GenreResponseWrapper(
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenreResponseWrapperToJson(
        GenreResponseWrapper instance) =>
    <String, dynamic>{
      'genres': instance.genres,
    };

GenreResponse _$GenreResponseFromJson(Map<String, dynamic> json) =>
    GenreResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreResponseToJson(GenreResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

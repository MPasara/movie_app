// ignore_for_file: always_use_package_imports

import 'package:dio/dio.dart';
import 'package:movie_app/common/data/genre_response.dart';
import 'package:movie_app/common/utils/constants/api_path_constants.dart';
import 'package:movie_app/features/popular/data/models/movie_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../example/data/models/example_user_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST('/token')
  Future<ExampleUserResponse> getUser();

  @GET(ApiPathConstants.moviePopular)
  Future<MovieResponseWrapper> getMovies(
    @Header('Authorization') String bearerToken,
    @Query('language') String language,
    @Query('page') int page,
  );

  @GET(ApiPathConstants.genres)
  Future<GenreResponseWrapper> getAllGenres(
    @Header('Authorization') String bearerToken,
  );
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/popular/domain/entities/movie.dart';

class MovieWrapper extends Equatable {
  final int totalPages;
  final int currentPage;
  final bool isLoading;
  final List<Movie> movies;

  const MovieWrapper({
    required this.totalPages,
    required this.currentPage,
    this.isLoading = false,
    required this.movies,
  });

  MovieWrapper copyWith({
    int? totalPages,
    int? currentPage,
    bool? isLoading,
    List<Movie>? movies,
  }) {
    return MovieWrapper(
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
    );
  }

  @override
  List<Object> get props => [
        totalPages,
        currentPage,
        isLoading,
        movies,
      ];
}

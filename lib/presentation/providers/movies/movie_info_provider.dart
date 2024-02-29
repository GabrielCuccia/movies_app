import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/datasources/movies_repository.dart';
import 'package:movies_app/presentation/providers/movies/movies_providers.dart';
import 'package:movies_app/presentation/providers/movies/movies_repository_provider.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch( MovieRepositoryProvider );
  
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

typedef GetMovieCallBack = Future<Movie>Function (String movieid);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>> {
  final GetMovieCallBack getMovie; 
  MovieMapNotifier(
    { required this.getMovie} ): super ({});

  
  


  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    print("realizando peticion http");
    
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }

}
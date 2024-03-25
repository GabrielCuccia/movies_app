
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/providers/movies/movies_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");


final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {

final movieRepository = ref.read(MovieRepositoryProvider); 

return SearchedMoviesNotifier(searchMovies: movieRepository.searchMovies, ref: ref);
});




typedef SearchMoviesCallBack = Future<List<Movie>> Function (String query);
class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {

  SearchMoviesCallBack searchMovies;
  final Ref ref;
  SearchedMoviesNotifier(
    
    {required this.searchMovies, required this.ref}
  ): super([]);
  Future<List<Movie>> searchMoviesByQuery(String query) async {

    ref.read(searchQueryProvider.notifier).update((state) => query);
    final List<Movie> movies = await searchMovies(query);
    state = movies;
    return movies;

  }
}
  
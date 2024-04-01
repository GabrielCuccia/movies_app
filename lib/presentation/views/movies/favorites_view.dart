import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:movies_app/presentation/widgets/movies/movie_mansonry.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();

  

}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  

  bool isLastPage = false;
  bool isLoading = false;
  

  @override
  void initState() {
    super.initState();
    
    loadNextPage();
    
    

  }
  void loadNextPage() async {
    if(isLoading  || isLastPage) return;
    isLoading = true;
    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if(movies.isEmpty){
      isLastPage = true;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if(favoritesMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary,),
            Text("Ohh no!!", style: TextStyle(fontSize: 30, color: colors.primary),),
            Text("No tienes peliculas favoritas", style: TextStyle(fontSize: 20, color: Colors.black45),)
        ]),
      );
    }
    return Scaffold(

      body: MovieMansory(movies: favoritesMovies, loadNextPage: loadNextPage,)
      
    );
  }
}
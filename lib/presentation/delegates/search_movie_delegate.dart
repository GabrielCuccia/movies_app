import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/helpers/human_formats.dart';
typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {


  final SearchMoviesCallBack searchMovies;

  List<Movie> initialMovies;
  StreamController<bool>  isLoadingStream = StreamController.broadcast();

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  SearchMovieDelegate( {required this.initialMovies, required this.searchMovies} );
  Timer? _debounceTimer;
  void _onQueryChanged(String query){

    isLoadingStream.add(true);

    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(Duration(milliseconds: 500), () async {
      

      final movies = await searchMovies(query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
     });

  }
  void clearStreams(){
    debouncedMovies.close();
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) {

    return [  

      StreamBuilder(
        initialData: false,
        stream: 
      isLoadingStream.stream, builder: (context, snapshot) {

        if(snapshot.data ?? false) { 
          return  SpinPerfect(
          infinite: true,
          duration: Duration(seconds: 2),
          child: IconButton(icon: Icon(Icons.refresh_rounded), onPressed: (){},)
         );
        } 
        return FadeIn(
        animate: query.isNotEmpty,
        duration: Duration(milliseconds: 150),
        child: IconButton(onPressed: () => query = "", icon: Icon(Icons.clear)));
      },),
     
      ];
  }

  @override
  String get searchFieldLabel => "Buscar Pelicula";

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(onPressed: () {
      clearStreams();
      close(context, null);

    }
     , icon: Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
     builder: (context, snapshot) {
      final movies = snapshot.data ?? [];
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          
          
          final movie = movies[index];
          return _MovieItem(movie: movie, onMovieSelected: (context, movie) {
            clearStreams();
            close(context, movie);
          } );
        },
      );
    },);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
      initialData: initialMovies,
    stream: debouncedMovies.stream,
    builder: (context, snapshot) {
      final movies = snapshot.data ?? [];
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          
          final movie = movies[index];
          return _MovieItem(movie: movie, onMovieSelected: (context, movie) {
            clearStreams();
            close(context, movie);
          } );
        },
      );
    },);
  }
  
}


class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({super.key, required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                
                child: Image.network(
                  
                  movie.posterPath ,fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child,);
                  }, )),
            ),
            SizedBox(width: 10,),
            SizedBox(width: size.width * 0.7, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textStyles.titleMedium,),
                movie.overview.length > 100 ? 
                Text("${movie.overview.substring(0,100)}...") :
                Text(movie.overview),
                Row(
                  children: [
                    Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                    SizedBox(width: 3,),
                    Text(
                      HumanFormats.number(movie.voteAverage, 1).toString()
                     , style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),)
                  ],
                )
                
              ],
            ),)
            
          ],
        ),
      ),
    );
  }
}
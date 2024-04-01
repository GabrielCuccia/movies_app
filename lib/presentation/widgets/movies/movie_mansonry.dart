import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/widgets/movies/movie_poster_link.dart';

class MovieMansory extends StatefulWidget {
  const MovieMansory({super.key, required this.movies, this.loadNextPage});
  
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  @override
  State<MovieMansory> createState() => _MovieMansoryState();
}

class _MovieMansoryState extends State<MovieMansory> {
  final scrollController = ScrollController();

  @override
  void initState() {
    
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if((scrollController.position.pixels + 100) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
      
    });
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: MasonryGridView.count(
        controller: scrollController,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        crossAxisCount: 3, itemBuilder: (context, index) {
          if(index == 1 ){
            return Column(
              children: [
                const SizedBox(height: 40,),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }

        return MoviePosterLink(movie: widget.movies[index] );
      },),
    );
  }
}


import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';

class MoviesSlidesShow extends StatelessWidget {
  const MoviesSlidesShow({super.key, required this.movies, });
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
      viewportFraction: 0.8,
      scale: 0.9,
      autoplay: true,  
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _Slide(movie: movie);
      },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(
        0,10
      ))]
    );

    return Padding(
    padding: EdgeInsets.only( bottom: 30),
    child: DecoratedBox(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.backdropPath,
           fit: BoxFit.cover,
           loadingBuilder: (context, child, loadingProgress) {
             if(loadingProgress != null){
              return DecoratedBox(decoration: BoxDecoration(
                color: Colors.black12
              ));

             }
             return child;
           },
           ))),
    );
  }
}
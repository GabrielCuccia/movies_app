import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/datasources/local_storage_repository.dart';
import 'package:movies_app/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:movies_app/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:movies_app/presentation/providers/movies/movie_info_provider.dart';
import 'package:movies_app/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:movies_app/presentation/providers/storage/local_storage_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key, required this.movieId});

  static const name = "movie-screen";
  final String movieId;



  @override
  MovieScreenState createState() => MovieScreenState();
}



class MovieScreenState extends ConsumerState<MovieScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {


    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return Scaffold(body: const Center(child: CircularProgressIndicator(strokeWidth: 2,)));
    }
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1
          ))
        ],
      ),
    );
  }
}



class _MovieDetails extends StatelessWidget {
  const _MovieDetails({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.all(8), child: 
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(movie.posterPath,
              width: size.width * 0.3,
              ),
              

            ),
            SizedBox(width: 10,),
            SizedBox(width: (size.width - 40 ) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(movie.title, style: textStyles.titleLarge,),
              Text(movie.overview)
            ]),
            
            
            ),
            

          ],
        )
        ,),

        Padding(padding: EdgeInsets.all(8),
        child: Wrap(
          children: [
            ...movie.genreIds.map((e) => Container(
              margin: const EdgeInsets.only( right: 10),
              child: Chip(label: 
              Text(e),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ))
          ],
        ),
        ),
        _ActorsByMovie(movieId: movie.id.toString()),
        SizedBox(height: 100,)
      ],
      
    );
  }
}








final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(locaLStorageRepositoryProvider);


  return localStorageRepository.isMovieFavorite(movieId);
});



class _CustomSliverAppBar extends ConsumerWidget {
  const _CustomSliverAppBar({super.key, required this.movie});
  final Movie movie;
  
  @override
  Widget build(BuildContext context, ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      actions: [
        IconButton(onPressed: () async {
          await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);

          ref.invalidate(isFavoriteProvider(movie.id));
        },  icon: isFavoriteFuture.when(
            data: (isFavorite) => isFavorite ? Icon(Icons.favorite_rounded, color: Colors.red,) : Icon(Icons.favorite_border),
            error: (error, stackTrace) => throw UnimplementedError(),
            loading: () => Icon(Icons.favorite_border),))
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          SizedBox.expand(child: Image.network(movie.posterPath, fit: BoxFit.cover,),
          ),
          const SizedBox.expand(child: DecoratedBox(decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black87, Colors.transparent
            ], begin: Alignment.topRight, end: Alignment.bottomLeft, stops: [0.0, 0.2])
          )),),
          const SizedBox.expand(child: DecoratedBox(decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.transparent, Colors.black87
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 1.0])
          )),),
          const SizedBox.expand(child: DecoratedBox(decoration: BoxDecoration(
            gradient: LinearGradient(colors: [ Colors.black87,Colors.transparent
            ], begin: Alignment.topLeft, stops: [0.0, 0.3])
          )),)
        ]),
        titlePadding: EdgeInsets.only(bottom: 20, left: 20),
        title: Text(movie.title, style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
      ),
      
    );
  }
  
}

class _ActorsByMovie extends ConsumerWidget {
  const _ActorsByMovie({super.key, required this.movieId});
  final String movieId;
  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null){
      return CircularProgressIndicator(strokeWidth: 2,);
    }
    final actors = actorsByMovie[movieId]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
        final actor = actors[index];
        return Container(
          padding: EdgeInsets.all(8.0),
          width: 135,child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ClipRRect(

              borderRadius: BorderRadius.circular(20),
              child: Image.network(actor.profilePath, height: 180, width: 135,
              fit: BoxFit.cover,),
            ),
            const SizedBox(height: 5,),
            Text(actor.name, maxLines: 2,),
            Text(actor.character ?? "", maxLines: 2, style: TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),)
          ]),
        );
      },
      itemCount: actors.length,
      
      ),
    );
  }
}
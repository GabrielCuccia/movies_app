import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/domain/entities/actor.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/datasources/actor_repository.dart';
import 'package:movies_app/domain/repositories/datasources/movies_repository.dart';
import 'package:movies_app/presentation/providers/actors/actors_by_repository_provider.dart';
import 'package:movies_app/presentation/providers/movies/movies_providers.dart';
import 'package:movies_app/presentation/providers/movies/movies_repository_provider.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch( ActorsRepositoryProvider );
  
  return ActorByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});

typedef GetActorsCallBack = Future<List<Actor>> Function (String movieid);

class ActorByMovieNotifier extends StateNotifier<Map<String,List<Actor>>> {
  final GetActorsCallBack getActors; 
  ActorByMovieNotifier(
    { required this.getActors} ): super ({});

  
  


  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    
    
    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }

}
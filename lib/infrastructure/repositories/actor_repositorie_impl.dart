import 'package:movies_app/domain/datasources/actors_datasource.dart';
import 'package:movies_app/domain/entities/actor.dart';
import 'package:movies_app/domain/repositories/datasources/actor_repository.dart';

class ActorRespositoryImpl extends ActorsRepository{

  final ActorsDatasource datasource;

  ActorRespositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return datasource.getActorsByMovie(movieId);
  }

}
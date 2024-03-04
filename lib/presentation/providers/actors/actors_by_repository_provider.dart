import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:movies_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movies_app/infrastructure/repositories/actor_repositorie_impl.dart';
import 'package:movies_app/infrastructure/repositories/movie_repository_impl.dart';

final ActorsRepositoryProvider = Provider((ref) {
  return ActorRespositoryImpl(datasource: ActorMovieDbDatasource());
});
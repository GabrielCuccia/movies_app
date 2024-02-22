import 'package:movies_app/domain/datasources/movie_datasources.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/datasources/movies_repository.dart';

class MovieRepositoryImpl extends MovieRepository {

  
  final MovieDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return this.datasource.getNowPlaying(page: page);
  }
  
}
import 'package:movies_app/domain/entities/movie.dart';

abstract class MovieDatasource {

 Future <List<Movie>> getNowPlaying({int page = 1});
 Future <List<Movie>> getPopular({int page = 1});

}
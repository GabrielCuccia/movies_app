import 'package:dio/dio.dart';
import 'package:movies_app/config/constans/environment.dart';
import 'package:movies_app/domain/datasources/movie_datasources.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/infrastructure/mappers/movie_mapper.dart';
import 'package:movies_app/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MovieDatasource {

  final dio = Dio(
    BaseOptions(baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.theMovieDbKey,
      "language": "es-MX"
      
    }
    ),
    
  );


  List<Movie> _jsonToMovies (Map<String, dynamic> json){

    final movieDBResponse = MovieDbResponse.fromJson(json);
   final List<Movie> movies = movieDBResponse.results.where((moviedb) => moviedb.posterPath != "no-poster")
   .map(
    (moviedb) => MovieMapper.movieDBToEntiry(moviedb)
    ).toList();
   

    return movies;

  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
   final response = await dio.get("/movie/now_playing",
   queryParameters: {
    "page": page
   }
   );
   return _jsonToMovies(response.data);
   
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get("/movie/popular",
   queryParameters: {
    "page": page
   }
   );
   
    return _jsonToMovies(response.data);

  }
}
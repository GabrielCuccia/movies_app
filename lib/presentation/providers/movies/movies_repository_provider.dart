

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movies_app/infrastructure/repositories/movie_repository_impl.dart';

final MovieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
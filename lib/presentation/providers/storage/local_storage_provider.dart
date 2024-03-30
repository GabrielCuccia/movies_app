import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/infrastructure/datasources/isar_datasource.dart';
import 'package:movies_app/infrastructure/repositories/local_storage_repository_impl.dart';

final locaLStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: IsarDatasource());
});
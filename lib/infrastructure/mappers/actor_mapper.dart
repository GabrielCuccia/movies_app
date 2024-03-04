import 'package:movies_app/domain/entities/actor.dart';
import 'package:movies_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => 
  Actor(id: cast.id,
   name: cast.name,
    profilePath: cast.profilePath != null ? "https://image.tmdb.org/t/p/w500/${cast.profilePath}":
    "https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png"
    ,
     character: cast.character);
}
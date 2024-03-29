import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/infrastructure/models/movie_moviedb.dart';
import 'package:movies_app/infrastructure/models/moviedb/movie_details.dart';

class MovieMapper {
  static Movie movieDBToEntiry(MovieFromMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: movieDB.backdropPath != ""
          ? "https://image.tmdb.org/t/p/w500/${movieDB.backdropPath}"
          : "https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg",
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: movieDB.posterPath != " "
          ? "https://image.tmdb.org/t/p/w500/${movieDB.posterPath}"
          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-r_cd2YunvZ5iqRYvb4QJ312hlRGqDNnTRmLVuxRw7CDnH1yQLf6dKrCdJ-9dCrwukHI&usqp=CA",
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);


    static Movie movieDetailsToEntity(MovieDetails movieDB) => Movie(

      adult: movieDB.adult,
      backdropPath: movieDB.backdropPath != ""
          ? "https://image.tmdb.org/t/p/w500/${movieDB.backdropPath}"
          : "https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg",
      genreIds: movieDB.genres.map((e) => e.name).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: movieDB.posterPath != ""
          ? "https://image.tmdb.org/t/p/w500/${movieDB.posterPath}"
          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-r_cd2YunvZ5iqRYvb4QJ312hlRGqDNnTRmLVuxRw7CDnH1yQLf6dKrCdJ-9dCrwukHI&usqp=CAU",
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);

    

}

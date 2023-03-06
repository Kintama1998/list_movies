import 'package:list_movie/features/movie_popular/models/movie.dart';
import 'package:dio/dio.dart';

class MovieApis {
  static String url = 'https://api.themoviedb.org';

  static Future<List<Movie>> fetchListMovies({page = 1}) async {
    String endpoint =
        '/3/discover/movie?api_key=26763d7bf2e94098192e629eb975dab0&page=$page';
    var response = await Dio().get(url + endpoint);
    if (response.statusCode != 200) return [];
    return List<Movie>.from(
         response.data['results'].map((json) => Movie.fromJson(json)));
  }
}

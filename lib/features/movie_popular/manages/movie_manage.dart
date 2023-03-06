import 'dart:async';

import 'package:list_movie/services/movie_apis.dart';

import '../models/movie.dart';

class PopularMovieManage {
  //Stream listmovies
  final StreamController sinkMovie = StreamController();
  Stream get streamMovie => sinkMovie.stream;
  //Stream handle display header
  final StreamController<bool> sinkHeader = StreamController<bool>.broadcast();
  Stream get streamHeader => sinkHeader.stream;
  //Stream handle display loadmore
  final StreamController<bool> sinkLoadmore =
      StreamController<bool>.broadcast();
  Stream get streamLoadmore => sinkLoadmore.stream;
  /////////
  

  int page = 1;
  List<Movie> listMovie = [];
  void increamentPage() {
    fetchListMovies();
  }

  void fetchListMovies() async {
    List<Movie> list = await MovieApis.fetchListMovies(page: page);
    if (list.isNotEmpty) {
      listMovie.addAll(list);
      sinkMovie.sink.add(listMovie);
      page += 1;
    }
    sinkLoadmore.sink.add(false);
  }
  
  void refreshListMovie() async{
    page = 1;
    listMovie.clear();
    fetchListMovies(); 
  }

  PopularMovieManage() {
    fetchListMovies();
  }
  /////////
  void isChangeStatusHeader(bool value) {
    sinkHeader.sink.add(value);
  }

  void isChangeStatusLoadmore(bool value) {
    if (value == true) {
      sinkLoadmore.sink.add(value);
      fetchListMovies();
    }
  }

  void dispose() {
    sinkMovie.close();
    sinkHeader.close();
    sinkLoadmore.close();
  }
}

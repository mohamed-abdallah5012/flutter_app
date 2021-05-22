import 'package:flutter/foundation.dart';
import 'package:flutter_app/data/data_base.dart';
import '../models/Movie.dart';
import '../models/APIResponse.dart';

import 'package:dio/dio.dart';

class MoviesModel extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> _favourites = [];
  AppDataBase dataBase = AppDataBase();

  List<Movie> get movies => _movies;
  List<Movie> get favMovies => _favourites;

  getNowPlayingMoviesFromApi(String type) async {
    try {
      print("inside provider");
      var response = await Dio().get(
          "https://api.themoviedb.org/3/movie/${type}?api_key=f55fbda0cb73b855629e676e54ab6d8e");
      APIResponse apiResponse = APIResponse.fromMap(response.data);
      for (var item in response.data["results"]) {
        Movie cmoingMoviee = Movie.fromMap(item);
        _movies.add(cmoingMoviee);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getFavouritesMovies() {
    dataBase.getMovies().then((movies) {
      _favourites = movies;
      notifyListeners();
    });
  }

  inserFav(Movie movie) {
    dataBase.insertMovie(movie);
    print("inserted");
  }
}

import 'package:flutter/material.dart';
import './models/Movie.dart';
import './models/APIResponse.dart';
import 'main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PopularMovies extends StatefulWidget {
  @override
  PopularMoviesScreen createState() => PopularMoviesScreen();
}

class PopularMoviesScreen extends State<StatefulWidget> {
  List<Movie> movies;
  Movie movie;

  Future<List<Movie>> callAPI() async {
    try {
      var response = await Dio().get(
          "https://api.themoviedb.org/3/movie/now_playing?api_key=f55fbda0cb73b855629e676e54ab6d8e");
      print(response.data is Map);
      APIResponse apiResponse = APIResponse.fromMap(response.data);
      print(apiResponse.total_pages);

      for (var item in response.data["results"]) {
        Movie cmoingMoviee = Movie.fromMap(item);
        movies.add(cmoingMoviee);
        print(cmoingMoviee.title);
      }
      print("length of list after loading ${movies.length}");
      print(apiResponse.page);
      setState(() {});
      return movies;
      // setState(() {});
    } catch (e) {
      print(e);
    }
    return movies;
  }

  @override
  void initState() {
    callAPI();
    movie = Movie();
    movie.title = "Star Wars III";
    movie.vote_count = 2452;
    movie.poster_path = "/13B6onhL6FzSN2KaNeQeMML05pS.jpg";
    movie.release_date = "2019/12/31";
    movie.overview = "Movie Description";
    movies = [];
    // movies.add(movie);
    // movies.add(movie);
    // movies.add(movie);
    // movies.add(movie);
    // movies.add(movie);
    // movies.add(movie);
    // movies.add(movie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("list count ${movies.length}");
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text("Now Playing"),
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
          future: callAPI(),
          builder: (context, movieSpanShot) {
            if (movieSpanShot.connectionState == ConnectionState.waiting &&
                !movieSpanShot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (movieSpanShot.hasError) {
              return Center(child: Text(movieSpanShot.error.toString()));
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      child: Row(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w200${movies[index].poster_path}",
                            height: 100,
                            width: 150,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 190,
                              child: Text(
                                movies[index].title,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                maxLines: 2,
                              ),
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 4,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 12,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.cyanAccent,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                Text(
                                  "   ${movie.vote_count}  reviews",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later,
                                  color: Colors.white,
                                  size: 13,
                                ),
                                Text(" Duration",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 13,
                                ),
                                Text(" ${movie.release_date}",
                                    style: TextStyle(color: Colors.white))
                              ],
                            )
                          ],
                        )
                      ]),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title: "Second Screen",
                                    comingMovie: movies[index],
                                  )));
                    },
                  );
                },
              );
            }
          },
        ));
  }
}

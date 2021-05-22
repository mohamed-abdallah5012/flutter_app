import 'package:flutter/material.dart';
import 'package:flutter_app/provider/movies_model.dart';
import 'package:provider/provider.dart';
import '../models/Movie.dart';
import '../main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MoviesModel>(context, listen: false)
          .getNowPlayingMoviesFromApi("now_playing"),
      builder: (context, movieSpanShot) {
        if (movieSpanShot.connectionState == ConnectionState.waiting &&
            !movieSpanShot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (movieSpanShot.hasError) {
          return Center(child: Text(movieSpanShot.error.toString()));
        } else {
          return Consumer<MoviesModel>(builder: (_, moviesModel, __) {
            List<Movie> movies = moviesModel.movies;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Hero(
                          tag:
                              "https://image.tmdb.org/t/p/w200${movies[index].poster_path}",
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w200${movies[index].poster_path}",
                            height: 100,
                            width: 150,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 190,
                            child: Text(
                              movies[index].title,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                                "   ${movies[index].vote_count}  reviews",
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
                              Text(" ${movies[index].release_date}",
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
          });
        }
      },
    );
  }
}

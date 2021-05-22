import 'package:flutter/material.dart';
import 'package:flutter_app/provider/movies_model.dart';
import 'package:provider/provider.dart';
import '../models/Movie.dart';
import '../main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<MoviesModel>(context).getFavouritesMovies();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesModel>(builder: (_, moviesModel, __) {
      List<Movie> movies = moviesModel.favMovies;
      return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: ListView.builder(
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
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
        ),
      );
    });
  }
}

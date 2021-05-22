import 'package:flutter/material.dart';
import 'package:flutter_app/provider/movies_model.dart';
import './models/Movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'app.dart';
import 'package:provider/provider.dart';

import 'data/data_base.dart';

void main() {
  AppDataBase dataBase = AppDataBase();
  dataBase.createDB();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.comingMovie}) : super(key: key);

  final String title;
  Movie comingMovie;
  @override
  _MyHomePageState createState() => _MyHomePageState(movie: comingMovie);
}

class _MyHomePageState extends State<MyHomePage> {
  Movie movie;
  _MyHomePageState({this.movie});
  @override
  void initState() {
    print(movie.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesModel>(builder: (_, moviesModel, __) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.blueGrey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: "https://image.tmdb.org/t/p/w200${movie.poster_path}",
                child: Image.network(
                  "https://image.tmdb.org/t/p/w200${movie.poster_path}",
                  width: MediaQuery.of(context).size.width,
                  // height: 500,
                  fit: BoxFit.fill,
                ),
              ),
              Text(movie.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, color: Colors.white)),
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
                    "  ${movie.vote_count}  reviews",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        moviesModel.inserFav(movie);
                      })
                ],
              ),
              Row(
                children: [
                  Icon(Icons.watch_later),
                  Text(" Duration", style: TextStyle(color: Colors.white))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text(" ${movie.release_date}",
                      style: TextStyle(color: Colors.white))
                ],
              ),
              Text("${movie.overview}", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}

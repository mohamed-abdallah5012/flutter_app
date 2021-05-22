import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/pojo/response.dart';

import 'details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.deepPurple),
      home: MyHomePage(title: 'Movie App'),
      routes: {
        '/MovieDetails': (context) => MyHomePage1(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> popular = [];
  List<Movie> upcoming = [];
  List<Movie> playing = [];
  List<Movie> topRating = [];

  Future<List<Movie>> getPlayingData() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=2');
      for (var m in response.data["results"]) {
        Movie movie = Movie.fromJson(m);

        playing.add(movie);
      }
    } catch (e) {
      print(e);
    }
    return playing;
  }

  Future<List<Movie>> getPopularData() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/popular?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=2');
      for (var m in response.data["results"]) {
        Movie movie = Movie.fromJson(m);
        popular.add(movie);
      }
    } catch (e) {
      print(e);
    }
    return popular;
  }

  Future<List<Movie>> getTopRatedData() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=2');
      for (var m in response.data["results"]) {
        Movie movie = Movie.fromJson(m);
        topRating.add(movie);
      }
    } catch (e) {
      print(e);
    }
    return topRating;
  }

  Future<List<Movie>> getUpcomingData() async {
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=2');
      for (var m in response.data["results"]) {
        Movie movie = Movie.fromJson(m);
        upcoming.add(movie);
      }
    } catch (e) {
      print(e);
    }
    return upcoming;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              leading: Icon(Icons.home_filled),
              title: Text("Now Playing"),
              actions: <Widget>[
                Consumer<MoviesModel>(builder: (ctx, model, __) {
                  print("llllllllllllllllll->${model.favMovies.length}");
                  return IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      print("want to navigate");
                      Navigator.push(
                          ctx,
                          MaterialPageRoute(
                              builder: (context) => Favourites()));
                      //   model.getFavouritesMovies();
                    },
                  );
                })
              ],
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Now Playing",
                  ),
                  Tab(
                    text: "Popular ",
                  ),
                  Tab(
                    text: "Top Rated",
                  ),
                  Tab(
                    text: "Upcoming",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                FutureBuilder<Object>(
                    future: getPopularData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return ListView.builder(
                          itemCount: popular.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/MovieDetails",
                                    arguments: popular[index]);
                              },
                              child: Container(
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 15, 10),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Hero(
                                                tag: popular[index].backdropPath,
                                                child: Image.network(
                                                    "https://image.tmdb.org/t/p/w500" +
                                                        popular[index]
                                                            .backdropPath),
                                              ))),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Text(
                                                popular[index].title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Row(children: [
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 5, 1, 5),
                                                  child: Text(
                                                    popular[index]
                                                            .voteCount
                                                            .toString() +
                                                        " Reviews",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  )),
                                            ]),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                  Text(popular[index].releaseDate,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timelapse,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                  Text("2h 59m",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          });
                    }),
                FutureBuilder<Object>(
                    future: getPlayingData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return ListView.builder(
                          itemCount: playing.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/MovieDetails",
                                    arguments: playing[index]);
                              },
                              child: Container(
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 15, 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Hero(
                                              tag: playing[index].backdropPath,
                                              child: Image.network(
                                                  "https://image.tmdb.org/t/p/w500" +
                                                      playing[index].backdropPath),
                                            ),
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Text(
                                                playing[index].title,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                ),
                                              )),
                                          Row(children: [
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(
                                                  0, 0, 1, 0),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                            ),
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(
                                                  0, 0, 1, 0),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                            ),
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(
                                                  0, 0, 1, 0),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                                size: 15,
                                              ),
                                            ),
                                            Container(
                                              padding: new EdgeInsets.fromLTRB(
                                                  0, 0, 1, 0),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 5, 1, 5),
                                                child: Text(
                                                  playing[index]
                                                          .voteCount
                                                          .toString() +
                                                      " Reviews",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                )),
                                          ]),
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey,
                                                  size: 15.0,
                                                ),
                                                Text(playing[index].releaseDate,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.0))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.timelapse,
                                                  color: Colors.grey,
                                                  size: 15.0,
                                                ),
                                                Text("2h 59m",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.0))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          });
                    }),
                FutureBuilder<Object>(
                    future: getTopRatedData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return ListView.builder(
                          itemCount: topRating.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/MovieDetails",
                                    arguments: topRating[index]);
                              },
                              child: Container(
                                  height: 100,
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 15, 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Hero(
                                                tag: topRating[index].backdropPath,
                                                child: Image.network(
                                                    "https://image.tmdb.org/t/p/w500" +
                                                        topRating[index]
                                                            .backdropPath),
                                              ),
                                            )),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 0),
                                                child: Text(
                                                  topRating[index].title,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                  ),
                                                )),
                                            Row(children: [
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 5, 1, 5),
                                                  child: Text(
                                                    topRating[index]
                                                            .voteCount
                                                            .toString() +
                                                        " Reviews",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  )),
                                            ]),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                  Text(topRating[index].releaseDate,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timelapse,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                  Text("2h 59m",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          });
                    }),
                FutureBuilder<Object>(
                    future: getUpcomingData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return ListView.builder(
                          itemCount: upcoming.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/MovieDetails",
                                    arguments: upcoming[index]);
                              },
                              child: Container(
                                  height: 100,
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 15, 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Hero(
                                                tag: upcoming[index].backdropPath,
                                                child: Image.network(
                                                    "https://image.tmdb.org/t/p/w500" +
                                                        upcoming[index].backdropPath),
                                              ),
                                            )),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 0),
                                                child: Text(
                                                  upcoming[index].title,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                  ),
                                                )),
                                            Row(children: [
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                  size: 15,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    new EdgeInsets.fromLTRB(
                                                        0, 0, 1, 0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 5, 1, 5),
                                                  child: Text(
                                                    upcoming[index]
                                                            .voteCount
                                                            .toString() +
                                                        " Reviews",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  )),
                                            ]),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                  Text(upcoming[index].releaseDate,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.timelapse,
                                                    color: Colors.grey,
                                                    size: 15.0,
                                                  ),
                                                  Text("2h 59m",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          });
                    }),
              ],
            )));
  }
}

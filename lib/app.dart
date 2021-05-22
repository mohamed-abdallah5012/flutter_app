import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/now_playing_screen.dart';
import './screens/top_rated_screen.dart';
import './screens/popular_screen.dart';
import './screens/upcoming_screen.dart';
import './provider/movies_model.dart';
import './screens/favourites_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MoviesModel(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: NowPlayingScreen(),
          home: DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Colors.blueGrey,
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
                  NowPlayingScreen(),
                  PopularScreen(),
                  TopRatedScreen(),
                  UpcomingScreen()
                ],
              ),
            ),
          ),
          // home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

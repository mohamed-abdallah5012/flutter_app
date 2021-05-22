import 'package:flutter/material.dart';
import 'package:flutter_app/pojo/response.dart';

class MovieDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage1(title: 'Movie Details'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage1 extends StatefulWidget {


  MyHomePage1({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage1> {

  @override
  Widget build(BuildContext context) {

    final Movie x= ModalRoute.of(context).settings.arguments ;

    print(x);

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: GestureDetector(
          onTap: () {
            print("back is pressed");
            Navigator.pop(context,"yes");

          },
          child: Icon(Icons.arrow_back),
        ),

        // title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: x.backdropPath,
            child: Image.network(
                "https://image.tmdb.org/t/p/w500" + x.backdropPath,
                width: double.infinity,
                fit: BoxFit.fill),
          )
          ,
          Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 1, 5),
              child: Text(
                x.title,
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )),
          Row(children: [
            Container(
              padding: new EdgeInsets.fromLTRB(10, 0, 1, 0),
              child: Icon(
                Icons.star,
                color: Colors.blue,
                size: 15,
              ),
            ),
            Container(
              padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
              child: Icon(
                Icons.star,
                color: Colors.blue,
                size: 15,
              ),
            ),
            Container(
              padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
              child: Icon(
                Icons.star,
                color: Colors.blue,
                size: 15,
              ),
            ),
            Container(
              padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 15,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 1, 5),
                child: Text(
                  "2.6k reviews",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                )),
          ]),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 1, 5),
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 15.0,
                    ),
                    Text("2h 59m",
                        style: TextStyle(color: Colors.grey, fontSize: 15.0))
                  ],
                ),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 1, 5),
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.blueGrey,
                      size: 15.0,
                    ),
                    Text("20-20-1995", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )),

          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              x.overview,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          )
        ],

      ),

    );
  }
}
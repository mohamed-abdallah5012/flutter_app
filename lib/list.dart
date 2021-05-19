import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Now Playing'),
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: GestureDetector(
          onTap: () {
            print("back is pressed");
          },
          child: Icon(Icons.arrow_back),
        ),

         title: Text(widget.title) ,centerTitle: false
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, int index) {
            return Container(
                height: 100,
                color: Colors.deepPurple,
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset("assets/img/1.jpg",
                              height: 100.0, width: 150.0, fit: BoxFit.fill),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Star Wars: Session 3",
                              style: TextStyle(color: Colors.white, fontSize: 17.0),
                            )),
                        Row(children: [
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
                        ]),                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 15.0,
                              ),
                              Text("20-4-1595",style: TextStyle(color: Colors.grey, fontSize: 15.0))
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
                              Text("2h 59m", style: TextStyle(color: Colors.grey, fontSize: 15.0))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ));
          }),
    );
  }
}

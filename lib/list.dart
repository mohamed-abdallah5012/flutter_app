import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/details.dart';
import 'package:flutter_app/pojo/response.dart';

class MovieList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Now Playing'),


    //initialRoute: '/',
    routes: {
       // '/':(context) =>MovieList(),
      '/MovieDetails' :(context) => MyHomePage1(),
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

  List<Movie> myList=[];
  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Movie>>getRemoteData() async{
    try {
      var response = await Dio().get('https://api.themoviedb.org/3/movie/now_playing?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=2');
      for (var m in response.data["results"])
      {
        Movie movie =Movie.fromJson(m);
        myList.add(movie);
      }
    } catch (e) {
      print(e);
    }
    return myList;

  }
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
           var x= Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetails()));
          print(x);
           },
          child: Icon(Icons.arrow_back),
        ),

         title: Text(widget.title) ,centerTitle: false
      ),
      body: FutureBuilder<Object>(
        future: getRemoteData(),
        builder :(context,snapshot){
          print("Connection Status"+snapshot.connectionState.toString());
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
           return ListView.builder
            (itemCount: myList.length,
              itemBuilder: (BuildContext  context,int index)
              {
                print("Container");
                return GestureDetector(
                  onTap:() {
                    print("gggggggggggggggggggggggggg"+myList[index].title);
                    Navigator.pushNamed(context,"/MovieDetails",arguments: myList[index]);

                  },
                  child: Container(
                      height: 100,
                      color: Colors.deepPurple,
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network("https://image.tmdb.org/t/p/w500"+myList[index].backdropPath),

                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(myList[index].title
                                    ,
                                    style: TextStyle(color: Colors.white, fontSize: 15.0,),
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
                      )),
                );
              });
      }
      ),
         );
    }
  }


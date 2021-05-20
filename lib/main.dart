import 'package:flutter/material.dart';
import 'package:flutter_app/pojo/response.dart';
import 'details.dart';
import 'list.dart';
import 'package:dio/dio.dart';


Future<void> main() async {

  // try {
  //   var response = await Dio().get('https://api.themoviedb.org/3/movie/now_playing?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1');
  //   //print(response.data);
  //   print(response.data["results"][0]);
  //   List <Movie> myList=[];
  //   for (var m in response.data["results"])
  //     {
  //       myList.add(m);
  //     }
  // } catch (e) {
  //   print(e);
  // }
  runApp(MovieList());
  //runApp(MovieDetails());
}

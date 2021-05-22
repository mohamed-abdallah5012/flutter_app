import 'package:flutter/material.dart';
import 'package:flutter_app/models/Movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  static final AppDataBase instance = AppDataBase._internal();
  Database dataBase;

  factory AppDataBase() {
    return instance;
  }

  AppDataBase._internal() {}

  createDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    dataBase = await openDatabase(
      join(await getDatabasesPath(), 'movies.db'),
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE movies(id INTEGER PRIMARY KEY, poster_path TEXT, vote_count INTEGER, title TEXT,release_date TEXT,overview TEXT)''');
      },
      version: 1,
    );
  }

  insertMovie(Movie movie) async {
    return await dataBase.insert('movies', movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Movie>> getMovies() async {
    final List<Map<String, dynamic>> movies = await dataBase.query('movies');
    return List.generate(movies.length, (i) {
      return Movie.fromMap(movies[i]);
    });
  }
}

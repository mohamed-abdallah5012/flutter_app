class Movie {
  Movie();
  bool adult;
  String backdrop_path;
  List<int> genre_ids;
  int id;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  String release_date;
  String title;
  bool video;
  double vote_average;
  int vote_count;

  Movie.fromMap(Map<String, dynamic> map) {
    poster_path = map["poster_path"];
    title = map["title"];
    vote_count = map["vote_count"];
    overview = map["overview"];
    release_date = map["release_date"];
  }
  Map<String, dynamic> toMap() {
    return {
      'poster_path': poster_path,
      'title': title,
      'vote_count': vote_count,
      'overview': overview,
      'release_date': release_date,
    };
  }
}

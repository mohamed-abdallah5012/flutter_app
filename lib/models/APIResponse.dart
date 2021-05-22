import './Movie.dart';

class APIResponse {
  Dates dates;
  List<Movie> results;
  // ignore: non_constant_identifier_names
  int total_pages;
  // ignore: non_constant_identifier_names
  int total_results;
  int page;

  APIResponse.fromMap(Map<String, dynamic> map) {
    // dates = map["dates"];
    // results = map["results"];
    total_pages = map["total_pages"];
    total_results = map["total_results"];
    page = map["page"];
  }
}

// ignore: camel_case_types
class Dates {
  String maximum;
  String minimum;
}

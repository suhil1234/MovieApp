// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter_application_1/controllers/ReviewsController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/MovieDetailesPage.dart';
import 'GenresController.dart';
import '../models/Movie.dart';
import '../constants/API-key.dart';


class MovieController extends GetxController {
  final GenresController favoritesController = Get.find();
  final MovieReviewsController movieReviewsController = Get.find();
  RxList<Movie> TrendingMovies = <Movie>[].obs;
  RxList<Movie> PopularMovies = <Movie>[].obs;
  RxList<Movie> UpcomingMovies = <Movie>[].obs;
 

  @override
  void onInit() {
    TrendingMoviesUrl();
    PopularMoviesUrl();
    UpcomingMoviesUrl();
    super.onInit();
  }

  void fetchMovies(String url,RxList<Movie> movie) async {
    try {

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      movie.value = data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      // Handle error
    }


    } catch (e) {
      // Handle exceptions
    }
  }
    void goToMovieDetails(Movie movie) {
      movieReviewsController.fetchReviews(movie.id);
    Get.to(() => MovieDetailesPage(movie: movie));
  }
  
  
   Future<void> TrendingMoviesUrl () async {
    String url = 'https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey';
    fetchMovies(url,TrendingMovies);
  }
   Future<void> PopularMoviesUrl () async {
    String url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
    fetchMovies(url,PopularMovies);
  }
   Future<void> UpcomingMoviesUrl () async {
    String url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';
    fetchMovies(url,UpcomingMovies);
  }
}
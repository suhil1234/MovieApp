import 'package:flutter_application_1/views/ForthPage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/API-key.dart';
import '../models/Genre.dart';
import '../models/Movie.dart';

class GenresController extends GetxController {
  final RxList<Genre> movieGeners = <Genre>[].obs;
  final RxList<Movie> movies = <Movie>[].obs;
  RxBool isLoading = RxBool(false);
  RxBool hasError = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchAllGenres();
 
  }

Future<void> fetchAllGenres() async {
  final url = Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey');
  isLoading.value = true;
  try {
    final response = await http.get(url);
    if(response.statusCode==200){
    final responseData = json.decode(response.body);
    movieGeners.value = (responseData['genres'] as List)
        .map((json) => Genre.fromJson(json))
        .toList();
    print(responseData);
    }else{
      hasError.value = true;
    }
  } catch (error) {
     hasError.value = true;
    }
    finally {
      isLoading.value = false;
      hasError.value= false;
    }
}

Future<void> fetchGenereMovies(int genreId) async {
  final url = Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId');
  isLoading.value = true;
  try {
    final response = await http.get(url);
    if(response.statusCode==200){
    final responseData = json.decode(response.body);
     movies.value = (responseData['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    }else{
      hasError.value = true;
    }
  } catch (error) {
     hasError.value = true;
    }
    finally {
      isLoading.value = false;
      hasError.value = false;
    }
}

  void goToGenreMovies(Genre genre) {
      fetchGenereMovies(genre.id);
    Get.to(() => ForthPage(genre: genre,));
  }
}

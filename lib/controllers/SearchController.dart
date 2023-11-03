import 'dart:convert';
import 'package:flutter_application_1/models/Movie.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/Review.dart';
import '../constants/API-key.dart';

class SearchController extends GetxController {
  RxList<Movie> Results = RxList<Movie>([]);
  RxBool isLoading = RxBool(false);
  RxBool hasError = RxBool(false);

  Future<void> searchMovies(String query) async {
    isLoading.value = true;
      final url = Uri.https(
      'api.themoviedb.org',
      '/3/search/movie',
      {
        'api_key': apiKey,
        'query': query,
      },
    );
    try {
      final response = await http.get(url); // Replace with your actual API endpoint
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        Results.value = data.map((result) => Movie.fromJson(result)).toList();
      } else {
        hasError.value = true;
      }
    } catch (e) {
      print('sdsdsd');
      print(e);
      hasError.value = true;
    }
    finally {
      isLoading.value = false;
    }
  }
}
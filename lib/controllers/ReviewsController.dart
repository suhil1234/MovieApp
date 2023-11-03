import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/Review.dart';
import '../constants/API-key.dart';

class MovieReviewsController extends GetxController {
  RxList<RxBool> isExpandedList = RxList<RxBool>([]);
  RxList<Review> reviews = RxList<Review>([]);
  RxBool isLoading = RxBool(false);
  RxBool hasError = RxBool(false);

  Future<void> fetchReviews(int id) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id/reviews?api_key=$apiKey')); // Replace with your actual API endpoint
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];
        reviews.value = data.map((review) => Review.fromJson(review)).toList();
        print(data);
        isExpandedList.value = List<RxBool>.generate(reviews.length, (_) => false.obs);
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
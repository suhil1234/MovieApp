import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/MovieCard.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/MovieController.dart';


class HomePage extends GetView<MovieController> {
  final movieController = Get.put(MovieController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        if (controller.TrendingMovies.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text('Trending Movies',   
                  style: TextStyle(
                  fontSize: 14,),),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Container(
                  height: height/2,
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.TrendingMovies.length,
                  itemBuilder: (context, index) {
                  final movie = controller.TrendingMovies[index];
                  return MovieCard(movie: movie, titleSize: 12, ratingSize: 10,);
                  })),
                  SizedBox(height: 10,),
                  Text('Top Rated Movies',style: TextStyle(fontSize: 14),),
                  SizedBox(height: 8,),
                  Container(
                  height: height/3,
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.PopularMovies.length,
                  itemBuilder: (context, index) {
                  final movie = controller.PopularMovies[index];
                  
                  return MovieCard(movie: movie, titleSize: 10, ratingSize: 10,);
                  })),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}



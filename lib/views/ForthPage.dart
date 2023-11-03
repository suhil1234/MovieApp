import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/controllers/GenresController.dart';
import 'package:get/get.dart';
import '../models/Genre.dart';
import 'widgets/MovieCard.dart';

class ForthPage extends StatelessWidget {
   ForthPage({super.key, required this.genre});

  final Genre genre;
  GenresController genresController = Get.put(GenresController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Text(genre.name),
          SizedBox(height: 20,),
           Obx(
              () {
                if (genresController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (genresController.hasError.value) {
                  return Center(
                    child: Text('Error Fetching Movies'),
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two cards per row
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5
                      ),
                      itemCount: genresController.movies.length,
                      itemBuilder: (context, index) {
                        final movie = genresController.movies[index];
                        return Expanded(child: MovieCard(movie: movie, titleSize: 16, ratingSize: 14,));
                      },
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
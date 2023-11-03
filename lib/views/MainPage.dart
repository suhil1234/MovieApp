import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/GenresController.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/MovieController.dart';
import '../constants/Icons.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final movieController = Get.put(MovieController());
  final GenresController genreMoviesController = Get.put(GenresController());

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Upcoming Movies',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Obx(
                () => CarouselSlider.builder(
                  itemCount: movieController.UpcomingMovies.length,
                  itemBuilder: (context, index, realIndex) {
                    final movie = movieController.UpcomingMovies[index];
                    return GestureDetector(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              tag: 'movieImage_${movie.id}',
                              child: Image.network(
                                movie.imageUrl,
                                width: 150,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      movie.rating.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        movieController.goToMovieDetails(movie);
                      },
                    );
                  },
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8, // Adjust this value to fit your needs
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Obx(
              () {
                if (genreMoviesController.isLoading.value) {
                  return CircularProgressIndicator(); // Show loading indicator while fetching genres
                } else if (genreMoviesController.hasError.value) {
                  return Text('Failed to load genres'); // Show error message if fetching genres fails
                } else {
                  return ListView.builder(
                    shrinkWrap: true, // Added to prevent overflow
                    itemCount: genreMoviesController.movieGeners.length,
                    itemBuilder: (context, index) {
                      final genre = genreMoviesController.movieGeners[index];
                      final icon = genreIcons[genre.id] ?? Icons.category;
                      return ListTile(
                        hoverColor: Colors.purple[300],
                        title: Text(genre.name),
                        trailing: Icon(Icons.arrow_forward),
                        leading: Icon(icon),
                        onTap: () {
                          genreMoviesController.goToGenreMovies(genre);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
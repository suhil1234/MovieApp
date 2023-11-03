import 'package:flutter/material.dart';
import '../../controllers/MovieController.dart';
import '../../models/Movie.dart';
import 'package:get/get.dart';

class MovieCard extends StatelessWidget {
   MovieCard({
    Key? key,

    required this.movie, required this.titleSize, required this.ratingSize,
  }) : super(key: key);

  MovieController controller = Get.put(MovieController());
  final Movie movie;
  final double titleSize;
  final double ratingSize;


  @override
  Widget build(BuildContext context) {

          final isFavorite = false; // Get the favorite status using GetX

          return GestureDetector(
            onTap: () {
              controller.goToMovieDetails(movie);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Card(
                elevation: 1,
                shadowColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor, // Replace with your desired primary color
                    width: 2.0,
                  ),
                ),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 0.5, // Height is double than width
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0),
                              ),
                              child: Hero(
                                tag: 'movieImage_${movie.id}',
                                child: Image.network(
                                  movie.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getTruncatedTitle(movie.title),
                                  style: TextStyle(
                                    fontSize: titleSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      movie.rating.toStringAsFixed(1),
                                      style: TextStyle(
                                        fontSize: ratingSize,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.star, color: Colors.yellow, size: 12),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
  }

  String _getTruncatedTitle(String title) {
    final int maxLength = 25; // Set the maximum length of the title
    if (title.length > maxLength) {
      return title.substring(0, maxLength - 3) + "...";
    } else {
      return title;
    }
  }
}
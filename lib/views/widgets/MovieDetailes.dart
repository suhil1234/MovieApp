import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ReviewsController.dart';
import '../../models/Movie.dart';

class MovieDetailes extends StatefulWidget {

   MovieDetailes({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;
  



  @override
  State<MovieDetailes> createState() => _MovieDetailesState();
}

class _MovieDetailesState extends State<MovieDetailes> {
 final MovieReviewsController movieReviewsController =
  Get.put(MovieReviewsController());
  
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Rating : '),
                Container(
                  height: 5.0,
                  width: 5.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                Row(
                  children: [
                    Text(widget.movie.rating.toStringAsFixed(1)),
                    SizedBox(width: 5),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          const Divider(color: Colors.black, height: 1.0),
          const SizedBox(height: 16.0),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            widget.movie.overview,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
        ],
      ),
    );
  }
}
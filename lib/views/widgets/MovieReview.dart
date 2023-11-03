import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/ReviewsController.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.movieReviewsController,
  }) : super(key: key);

  final MovieReviewsController movieReviewsController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movieReviewsController.reviews.length,
      itemBuilder: (context, index) {
        final review = movieReviewsController.reviews[index];
        final avatarUrl = 'https://image.tmdb.org/t/p/w200${review.authorDetails.avatarPath}';
        final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(review.createdAt);
            return Card(
      elevation: 1,
      shadowColor: Colors.purple[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Colors.purple,// Replace with your desired primary color
          width: 1.0,
        ),
      ),
      child: Obx(
         () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text(review.author, style: TextStyle(fontSize: 12),),
                    subtitle: Text(formattedDateTime),
                    leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl ?? ''),),
                    trailing: review.authorDetails.rating!=null? 
                    Text(review.authorDetails.rating.toString()+'/10',style: TextStyle(color: Colors.amber),):
                    Text('??/10',style: TextStyle(color: Colors.amber))
                  ),
                ),
                
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Text(
                    review.content,
                    style: TextStyle(fontSize: 12),
                    maxLines: movieReviewsController.isExpandedList[index].value ? 100 : 4,
                    overflow: TextOverflow.ellipsis,
                ),
                 ),
              
              if (review.content.split('\n').length >= 3)
                TextButton(
                  onPressed: () {
                     movieReviewsController.isExpandedList[index].value = ! 
                     movieReviewsController.isExpandedList[index].value;
                  },
                  child: Text(
                     movieReviewsController.isExpandedList[index].value ? 'Show Less' : 'Read More',
                    style: TextStyle(
    color: Colors.purple[100], // Replace with your desired color
                    ),
                  ),
                ),
            ],
          );
        }
      ),
    );
      },
    );
  }
}

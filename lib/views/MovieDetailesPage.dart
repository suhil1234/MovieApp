import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/MovieAppBar.dart';
import 'package:flutter_application_1/views/widgets/MovieReview.dart';
import 'package:get/get.dart';
import '../controllers/ReviewsController.dart';
import '../models/Movie.dart';
import '../models/Review.dart';
import 'widgets/MovieDetailes.dart';

class MovieDetailesPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailesPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieReviewsController movieReviewsController =
        Get.put(MovieReviewsController());

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              MovieDetailAppBar(movie: movie),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: Colors.purple,
                    tabs: [
                      Tab(
                        text: 'Overview',
                      ),
                      Tab(
                        text: 'Reviews',
                      ),
                    ],
                  ),
                ),
                pinned: false,
              ),
            ];
          },
          body: TabBarView(
            children: [
              MovieDetailes(movie: movie),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Obx(
                  () {
                    if (movieReviewsController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (movieReviewsController.hasError.value) {
                      return Center(child: Text('Error fetching reviews'));
                    } else {
                      return ReviewCard(movieReviewsController: movieReviewsController,);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/SearchController.dart';
import 'package:flutter_application_1/views/widgets/MovieCard.dart';
import 'package:get/get.dart';

import '../../models/Movie.dart';

class SearchResultsPage extends StatelessWidget {
  final SearchController searchController = Get.put(SearchController());
  final TextEditingController TextsearchController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: TextsearchController,
              onChanged: (value) {
                searchController.searchMovies(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Obx(
              () {
                if (searchController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (searchController.Results.isEmpty) {
                  return const Center(
                    child: Text('No results found.',
                    style:TextStyle(fontSize: 18) ,),
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
                      itemCount: searchController.Results.length,
                      itemBuilder: (context, index) {
                        final movie = searchController.Results[index];
                        return Expanded(child: MovieCard(movie: movie, titleSize: 16, ratingSize: 14,));
                      },
                    ),
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
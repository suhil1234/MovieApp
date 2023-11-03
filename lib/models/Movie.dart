class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;
  final String overview;

  Movie({required this.id, required this.title, required this.imageUrl, required this.rating, required this.overview});

  factory Movie.fromJson(Map<String, dynamic> item) {
    return Movie(
        id: item['id'],
        title: item['title'],
        imageUrl: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
        rating: item['vote_average'].toDouble(),
        overview: item['overview'],
    );
  }
}


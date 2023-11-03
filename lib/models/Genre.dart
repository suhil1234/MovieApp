class Genre {
  final int id;
  final String name;
  final List<int> movieIds;

  Genre({required this.id, required this.name, required this.movieIds});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      movieIds: [],
    );
  }
}
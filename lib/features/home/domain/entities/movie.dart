class Movie {
  final int id;
  final String title;
  final List<int> genreIds;
  final double voteAverage;
  final String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.genreIds,
    required this.voteAverage,
    required this.posterPath,
  });
}
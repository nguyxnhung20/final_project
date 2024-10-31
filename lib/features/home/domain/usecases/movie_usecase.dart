import 'package:final_project/features/home/domain/entities/movie.dart';
import 'package:final_project/features/home/domain/repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>?> getNowPlayingMovies() async {
    return await repository.getMovies();
  }

  Future<List<Movie>?> getUpcommingMovie() {
    return repository.getUpcommingMovies();
  }
}

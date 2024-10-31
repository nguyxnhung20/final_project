import 'package:final_project/features/home/data/datasources/movie_remote_data_source.dart';
import 'package:final_project/features/home/domain/entities/genre.dart';
import 'package:final_project/features/home/domain/entities/image_configuration.dart';
import 'package:final_project/features/home/domain/entities/movie.dart';
import 'package:final_project/features/home/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Genre>?> getGenre() {
    return remoteDataSource.getGenre();
  }

  @override
  Future<ImageConfigInfo?> getImageInfo() {
    return remoteDataSource.getImageConfigInfo();
  }

  @override
  Future<List<Movie>?> getMovies() {
    return remoteDataSource.getMovies();
  }

  @override
  Future<List<Movie>?> getUpcommingMovies() {
    return remoteDataSource.getUpcommingMovies();
  }
}

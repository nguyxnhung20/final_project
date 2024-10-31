import 'package:final_project/core/apis/dio_client.dart';
import 'package:final_project/core/common/data/datasources/global_info_local_data_source.dart';
import 'package:final_project/core/common/data/repositories/global_repository_impl.dart';
import 'package:final_project/core/common/domain/repositories/global_repository.dart';
import 'package:final_project/core/common/domain/usecases/global_info_usecases.dart';
import 'package:final_project/features/home/data/datasources/movie_remote_data_source.dart';
import 'package:final_project/features/home/data/repositories/movie_repository_impl.dart';
import 'package:final_project/features/home/domain/repositories/movie_repository.dart';
import 'package:final_project/features/home/domain/usecases/movie_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(dio: getIt<DioClient>().dio));
  getIt.registerLazySingleton<GlobalInfoLocalDatasource>(
      () => GlobalInfoLocalDataSourceImpl(sharedPreferences: getIt()));

  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<GlobalRepository>(
      () => GlobalRepositoryImpl(localDatasource: getIt()));

  getIt.registerLazySingleton<GlobalInfoUsecases>(() => GlobalInfoUsecases(
        repository: getIt(),
        globalRepository: getIt(),
      ));
  getIt.registerLazySingleton<GetMovies>(() => GetMovies(getIt()));
}

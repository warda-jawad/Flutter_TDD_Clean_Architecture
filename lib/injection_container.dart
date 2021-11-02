import 'package:first_tdd_app/core/network/network_info.dart';
import 'package:first_tdd_app/core/util/input_converter.dart';
import 'package:first_tdd_app/featues/number-trivia/data/datasoureces/number_trivia_local_data_source.dart';
import 'package:first_tdd_app/featues/number-trivia/data/datasoureces/number_trivia_remote_data_source.dart';
import 'package:first_tdd_app/featues/number-trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/repositories/number_tivia_repository.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/usecases/get_concrete_number_tivia.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:first_tdd_app/featues/number-trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
//Features - Number Trivia
// Bloc
  sl.registerFactory(() =>
      NumberTriviaBloc(concrete: sl(), random: sl(), inputConverter: sl()));

// Use Case
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

// Core
  sl.registerLazySingleton(() => InputConverter());

  // Repository

  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Data Source

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

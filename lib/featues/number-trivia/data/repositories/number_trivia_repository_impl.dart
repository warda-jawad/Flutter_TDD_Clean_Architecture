import 'package:first_tdd_app/core/error/exeptions.dart';
import 'package:first_tdd_app/core/error/failuries.dart';
import 'package:first_tdd_app/core/network/network_info.dart';
import 'package:first_tdd_app/featues/number-trivia/data/datasoureces/number_trivia_local_data_source.dart';
import 'package:first_tdd_app/featues/number-trivia/data/datasoureces/number_trivia_remote_data_source.dart';
import 'package:first_tdd_app/featues/number-trivia/data/models/number_trivia_model.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/repositories/number_tivia_repository.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number)!;
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia()!;
    });
  }

  @override
  // return []
  List<Object?> get props => [];

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected == true) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia!);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }
}

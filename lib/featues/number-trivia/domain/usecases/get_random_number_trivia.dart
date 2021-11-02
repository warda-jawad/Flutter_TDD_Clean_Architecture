import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_tdd_app/core/error/failuries.dart';
import 'package:first_tdd_app/core/error/usecases/usecases.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/entities/number_trivia.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/repositories/number_tivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>?> execute(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}

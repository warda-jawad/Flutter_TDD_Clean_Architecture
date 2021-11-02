import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_tdd_app/core/error/failuries.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository extends Equatable {
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia();
}

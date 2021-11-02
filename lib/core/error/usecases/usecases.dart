import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/entities/number_trivia.dart';

import '../failuries.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, NumberTrivia>?> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

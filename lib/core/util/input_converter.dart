import 'package:dartz/dartz.dart';
import 'package:first_tdd_app/core/error/failuries.dart';

class InputConverter {
  Either<Failure, int>? stringToUsingTnteger(String str) {
    try {
      final intger = int.parse(str);
      if (intger < 0) throw FormatException();
      return Right(intger);
    } on FormatException {
      return Left(InvalidInputFalilure());
    }
  }
}

class InvalidInputFalilure extends Failure {
  @override
  List<Object?> get props => [];
}

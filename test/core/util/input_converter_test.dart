import 'package:dartz/dartz.dart';
import 'package:first_tdd_app/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group(" StringToUsingInt", () {
    test(
        'should return an intger when the string represents an unsigned intger',
        () async {
      // arrage
      final str = '123';
      // act
      final result = inputConverter.stringToUsingTnteger(str);

      // assert
      expect(result, Right(123));
    });

    test(
      'should return a failure when the string is not an integer',
      () async {
        // arrange
        final str = 'abc';
        // act
        final result = inputConverter.stringToUsingTnteger(str);
        // assert
        expect(result, Left(InvalidInputFalilure()));
      },
    );
    test(
      'should return a failure when the string is a negative integer',
      () async {
        // arrange
        final str = '-123';
        // act
        final result = inputConverter.stringToUsingTnteger(str);
        // assert
        expect(result, Left(InvalidInputFalilure()));
      },
    );
  });
}

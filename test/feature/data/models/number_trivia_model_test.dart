import 'dart:convert';

import 'package:first_tdd_app/featues/number-trivia/data/models/number_trivia_model.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "test");

  test(
    ' Should be a subclass of NumberTrivia entity',
    () async {
      //assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group(
    "from json",
    () {
      test('should return a vaild model the json number is an integer',
          () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        //act
        final result = NumberTriviaModel.fromJson(jsonMap);

        //assert
        expect(result, tNumberTriviaModel);
      });

      test(
          'should return a vaild model the json number is regarded ad a double',
          () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        //act
        final result = NumberTriviaModel.fromJson(jsonMap);

        //assert
        expect(result, tNumberTriviaModel);
      });
    },
  );

  group("to json", () {
    test('should return a josn map containig the proper data', () async {
      //act
      final result = tNumberTriviaModel.toJson();
      //assert

      final expectedMap = {"text": "test", "number": 1};
      expect(result, expectedMap);
    });
  });
}

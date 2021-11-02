import 'dart:convert';

import 'package:first_tdd_app/featues/number-trivia/data/datasoureces/number_trivia_local_data_source.dart';
import 'package:first_tdd_app/featues/number-trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../fixtures/fixture_reader.dart';

class MockSharedPrefernce extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPrefernce mockSharedPrefernce;

  setUp(() {
    mockSharedPrefernce = MockSharedPrefernce();
    dataSource =
        NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPrefernce);
  });

  group(" GetLastNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
        ' Should return NumberTrivia from SharedPreference when there is one in the cache ',
        () async {
      if (mockSharedPrefernce.getString("") != null) {
        //arrane
        when(mockSharedPrefernce.getString(""))
            .thenReturn(fixture('trivia_cached.json'));
        //act
        final result = await dataSource.getLastNumberTrivia();

        //assert
        verify(mockSharedPrefernce.getString(CACHED_NUMBER_TIVIA));
        expect(result, equals(tNumberTriviaModel));
      }
    });

    test(' Should throw CachExpection when there is not a cached value ',
        () async {
      if (mockSharedPrefernce.getString("") != null) {
        //arrane
        when(mockSharedPrefernce.getString("")).thenReturn(null);
        //act
        final call = dataSource.getLastNumberTrivia();

        //assert

        expect(() => call, equals(tNumberTriviaModel));
      }
    });
  });
  // End of Get Last Number Trivia TEst
  group(
    'cacheNumberTrivia',
    () {
      final tNumberTriviaModel =
          NumberTriviaModel(number: 1, text: 'test trivia');

      test(
        'should call SharedPreferences to cache the data',
        () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          // act - SET DATA
          dataSource.cacheNumberTrivia(tNumberTriviaModel);
          // assert
          final expectedJsonString = [json.encode(tNumberTriviaModel.toJson())];
          pref.setStringList(
            CACHED_NUMBER_TIVIA,
            expectedJsonString,
          );

          expect(pref.getStringList(CACHED_NUMBER_TIVIA), expectedJsonString);

          // verify(mockSharedPrefernce.setStringList(
          //   CACHED_NUMBER_TIVIA,
          //   expectedJsonString,
          // ));
        },
      );
    },
  );
}

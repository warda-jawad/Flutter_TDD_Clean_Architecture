import 'dart:convert';

import 'package:first_tdd_app/core/error/exeptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<NumberTriviaModel>? getLastNumberTrivia();

  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TIVIA = "CACHED_NUMBER_TIVIA";

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  late final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TIVIA);
    // Future which is immediately completed
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExeption();
    }
  }

  @override
  Future<SharedPreferences> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setStringList(
      CACHED_NUMBER_TIVIA,
      [json.encode(triviaToCache.toJson())],
    );
  }
}

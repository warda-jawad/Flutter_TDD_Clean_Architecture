part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  // const NumberTriviaState();
  NumberTriviaState([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

// class NumberTriviaInitial extends NumberTriviaState {}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  Loaded({required this.numberTrivia}) : super([numberTrivia]);
}

class Error extends NumberTriviaState {
  final String message;

  Error({required this.message}) : super([message]);
}

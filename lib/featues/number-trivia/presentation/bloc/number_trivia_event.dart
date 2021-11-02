part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  // const NumberTriviaEvent();
  NumberTriviaEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString) : super([numberString]);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}

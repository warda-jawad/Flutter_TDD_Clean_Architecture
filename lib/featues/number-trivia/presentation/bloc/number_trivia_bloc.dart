import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_tdd_app/core/error/failuries.dart';
import 'package:first_tdd_app/core/error/usecases/usecases.dart';
import 'package:first_tdd_app/core/util/input_converter.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/entities/number_trivia.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/usecases/get_concrete_number_tivia.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
    required InputConverter inputConverter,
  })  : getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        inputConverter = inputConverter,
        super(Empty());

  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUsingTnteger(event.numberString);
      if (inputEither != null) {
        yield* inputEither.fold(
          (failure) async* {
            yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
          },
          (integer) async* {
            yield Loading();
            final failureOrTrivia = await getConcreteNumberTrivia.execute(
              Params(number: integer),
            );
            yield* _eitherLoadedOrErrorState(failureOrTrivia!);
          },
        );
      }
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia.execute(
        NoParams(),
      );
      yield* _eitherLoadedOrErrorState(failureOrTrivia!);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> either,
  ) async* {
    yield either.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(
        numberTrivia: trivia,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

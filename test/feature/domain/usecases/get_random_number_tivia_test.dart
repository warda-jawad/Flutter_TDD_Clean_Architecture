import 'package:dartz/dartz.dart';
import 'package:first_tdd_app/core/error/usecases/usecases.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/entities/number_trivia.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/repositories/number_tivia_repository.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/usecases/get_concrete_number_tivia.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:first_tdd_app/featues/number-trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(text: "test", number: 1);

  test(
    ' Should get trivia from the repository',
    () async {
      print('---------------------');
      //arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));

      //act
      final result = await usecase.execute(NoParams());

      //assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}

// ignore: must_be_immutable
class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

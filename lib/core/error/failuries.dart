import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([
    List properties = const <dynamic>[],
  ]) : super();
}

class ServerFailure extends Failure {
  // two extra fuctions
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

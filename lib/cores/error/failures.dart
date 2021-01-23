import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends Failure {
  final String message;

  AuthenticationFailure({this.message});

  @override
  List<Object> get props => [message];
}

part of 'auths_bloc.dart';

abstract class AuthsState extends Equatable {
  const AuthsState();

  @override
  List<Object> get props => [];
}

class AuthsInitial extends AuthsState {}

class Authenticating extends AuthsState {}

class Authenticated extends AuthsState {
  final UserEntity userEntity;

  Authenticated({this.userEntity});
}

class AuthsError extends AuthsState {
  final String message;
  AuthsError({this.message});
}

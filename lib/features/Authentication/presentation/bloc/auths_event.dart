part of 'auths_bloc.dart';

abstract class AuthsEvent extends Equatable {
  const AuthsEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthsEvent {
  final UserEntity userEntity;
  RegisterEvent({this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class LoginEvent extends AuthsEvent {
  final UserEntity userEntity;
  LoginEvent({this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class LogOut extends AuthsEvent {}

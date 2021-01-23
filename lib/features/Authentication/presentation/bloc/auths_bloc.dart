import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:envoy/cores/error/failures.dart';
import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
import 'package:envoy/features/Authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'auths_event.dart';
part 'auths_state.dart';

class AuthsBloc extends Bloc<AuthsEvent, AuthsState> {
  AuthsBloc({this.initialState, this.repository}) : super(AuthsInitial());
  final AuthsState initialState;
  final AuthenticationRepository repository;

  @override
  Stream<AuthsState> mapEventToState(
    AuthsEvent event,
  ) async* {
    if (event is RegisterEvent) {
      yield* _registerUser(event.userEntity);
    } else if (event is LoginEvent) {
      yield* _loginUser(event.userEntity);
    } else if (event is LogOut) {
      repository.logout();
    }
  }

  Stream<AuthsState> _registerUser(UserEntity userEntity) async* {
    yield Authenticating();

    final response = await repository.registerUser(userEntity);
    yield* response.fold((failure) async* {
      yield AuthsError(message: failure.message);
    }, (credentials) async* {
      userEntity.id = credentials.user.uid.toString();
      final userData = await repository.saveTODatabase(userEntity);
      yield* userData.fold((failure) async* {
        yield AuthsError(message: failure.message);
      }, (success) async* {
        yield Authenticated(userEntity: userEntity);
      });
    });
  }

  Stream<AuthsState> _loginUser(UserEntity userEntity) async* {
    yield Authenticating();
    final response = await repository.loginUser(userEntity);
    yield* response.fold((failure) async* {
      yield AuthsError(message: failure.message);
    }, (success) async* {
      yield Authenticated();
    });
  }
}

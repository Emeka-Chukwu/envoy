import 'package:dartz/dartz.dart';
import 'package:envoy/cores/error/failures.dart';
import 'package:envoy/features/Authentication/data/model/user_model.dart';
import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Either<AuthenticationFailure, UserCredential>> registerUser(
      UserEntity userEntity);
  Future<Either<AuthenticationFailure, UserCredential>> loginUser(
      UserEntity userEntity);
  Future<Either<AuthenticationFailure, bool>> saveTODatabase(
      UserEntity userEntity);
  Future<Either<AuthenticationFailure, bool>> logout();
}

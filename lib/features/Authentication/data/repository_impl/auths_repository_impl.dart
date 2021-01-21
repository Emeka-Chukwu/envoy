import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
import 'package:envoy/cores/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:envoy/features/Authentication/domain/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticatedRepositoryImpl extends AuthenticationRepository {
  @override
  Future<Either<Failure, UserCredential>> loginUser(UserEntity userEntity) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> registerUser(UserEntity userEntity) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserCredential>> saveTODatabase(
      UserEntity userEntity) {
    // TODO: implement saveTODatabase
    throw UnimplementedError();
  }
}

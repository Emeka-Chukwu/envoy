import 'package:dartz/dartz.dart';
import 'package:envoy/cores/error/failures.dart';
import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, UserCredential>> registerUser(UserEntity userEntity);
}

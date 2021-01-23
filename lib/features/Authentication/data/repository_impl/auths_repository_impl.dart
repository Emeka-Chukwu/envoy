import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envoy/features/Authentication/data/model/user_model.dart';
import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
import 'package:envoy/cores/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:envoy/features/Authentication/domain/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticatedRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthenticatedRepositoryImpl(
      {@required this.firebaseAuth, @required this.firebaseFirestore})
      : assert(firebaseAuth != null),
        assert(firebaseFirestore != null);

  @override
  Future<Either<AuthenticationFailure, UserCredential>> loginUser(
      UserEntity userEntity) async {
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: userEntity.email, password: userEntity.password);
      return Right(userCredential);
    } on FirebaseAuthException catch (error) {
      return Left(AuthenticationFailure(message: error.message));
    } catch (err) {
      return Left(AuthenticationFailure(message: "Login failed"));
    }
  }

  @override
  Future<Either<AuthenticationFailure, bool>> logout() async {
    try {
      firebaseAuth.signOut();
      return Right(true);
    } on FirebaseAuthException catch (error) {
      return Left(AuthenticationFailure(message: error.message));
    } catch (err) {
      return Left(AuthenticationFailure(message: "Unable to logout"));
    }
  }

  @override
  Future<Either<AuthenticationFailure, UserCredential>> registerUser(
      UserEntity userEntity) async {
    UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: userEntity.email,
        password: userEntity.password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (error) {
      return Left(AuthenticationFailure(message: error.message));
    } catch (err) {
      return Left(AuthenticationFailure(message: "Sign up failed"));
    }
  }

  @override
  Future<Either<AuthenticationFailure, bool>> saveTODatabase(
      UserEntity userModel) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(userModel.id)
          .set(UserModel.fromEntity(userModel).toMap());
      return Right(true);
    } on FirebaseException catch (error) {
      return Left(AuthenticationFailure(message: error.message));
    } catch (err) {
      return Left(AuthenticationFailure(message: "unable to save"));
    }
  }
}

//  await firebaseFirestore
//           .collection('users')
//           .doc(userProfile.id)
//           .set(UserProfileModel.fromEntity(userProfile).toMap());
//       return Right(true);

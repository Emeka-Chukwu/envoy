import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:envoy/cores/error/failures.dart';
import 'package:envoy/features/Authentication/data/model/user_model.dart';
import 'package:envoy/features/Authentication/data/repository_impl/auths_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mock/mock.dart';

void main() {
  UserModel userModel;
  UserModel userModel1;
  // UserEntity userEntity;

  MockFireBaseAuth mockFirebaseAuth;
  FirebaseFirestore mockFirebaseFirestore;
  MockUserCredential mockUserCredential;
  AuthenticatedRepositoryImpl authenticatedRepositoryImpl;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference documentReference;
  MockFireBaseUser mockFireBaseUser;

  setUp(() {
    userModel = userModelData();
    userModel1 = userModelData2();
    // userEntity = userEntityData();
    mockUserCredential = MockUserCredential();
    mockFirebaseAuth = MockFireBaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    documentReference = MockDocumentReference();
    mockFireBaseUser = MockFireBaseUser();
    authenticatedRepositoryImpl = AuthenticatedRepositoryImpl(
      firebaseAuth: mockFirebaseAuth,
      firebaseFirestore: mockFirebaseFirestore,
    );
  });

  group("Sign up repository test ", () {
    test("Should return successful when a new user is created", () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed("email"), password: anyNamed("password")))
          .thenAnswer(
        (realInvocation) => Future.value(mockUserCredential),
      );
      final user = await authenticatedRepositoryImpl.registerUser(userModel);
      print(user);
      expect(user, equals(Right(mockUserCredential)));
    });

    test(
        "Should return [FirebaseAuthException] when user password is less than 6 ",
        () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Error());
      final user = await authenticatedRepositoryImpl.registerUser(userModel);
      print(user);
      print("user");

      expect(
          user, equals(Left(AuthenticationFailure(message: 'Sign up failed'))));
    });

    test('Should return [AuthenticationError] when registration fails',
        () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Error());
      final user = await authenticatedRepositoryImpl.registerUser(userModel);
      print(user);
      print("user");

      expect(
          user, equals(Left(AuthenticationFailure(message: 'Sign up failed'))));
    });

    test("Should [Verify] if signout is called or trigger", () async {
      await authenticatedRepositoryImpl.logout();
      verify(mockFirebaseAuth.signOut());
    });
  });

  group("Login test ", () {
    test("login successfull ", () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed("password")))
          .thenAnswer((realInvocation) => Future.value(mockUserCredential));

      final user = await authenticatedRepositoryImpl.loginUser(userModel);

      expect(user, equals(Right(mockUserCredential)));
    });

    test(' AuthFailure when error occurs during login y', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(AuthenticationFailure());

      final user = await authenticatedRepositoryImpl.loginUser(userModel);

      expect(
          user, equals(Left(AuthenticationFailure(message: 'Login failed'))));
    });

    test(' AuthFailure when error occurs during login j', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(AuthenticationFailure());

      final user = await authenticatedRepositoryImpl.loginUser(userModel);

      expect(
          user, equals(Left(AuthenticationFailure(message: 'Login failed'))));
    });

    test(' AuthFailure when error occurs during login h', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Error());

      final user = await authenticatedRepositoryImpl.loginUser(userModel);

      expect(
          user, equals(Left(AuthenticationFailure(message: 'Login failed'))));
    });
  });

  group("Firestore test caseses", () {
    test("success when data of the user has been saved to the database",
        () async {
      when(mockUserCredential.user).thenReturn(mockFireBaseUser);
      when(mockFireBaseUser.uid).thenReturn("user-id");
      when(mockFirebaseFirestore.collection(any))
          .thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(documentReference);
      when(documentReference.set(any)).thenAnswer((realInvocation) => null);

      final user = await authenticatedRepositoryImpl.saveTODatabase(userModel);

      expect(user, equals(Right(true)));
    });

    test("failure  when data of the user isn't saved to the database",
        () async {
      when(mockFirebaseFirestore.collection(any)).thenThrow(new Error());

      final user = await authenticatedRepositoryImpl.saveTODatabase(userModel);

      expect(
          user,
          Left(AuthenticationFailure(
              message: "failed to save data to database")));
    });

    test('should return an AuthFailure when it fails', () async {
      when(mockFirebaseFirestore.collection(any)).thenThrow(Error());

      final user = await authenticatedRepositoryImpl.saveTODatabase(userModel);

      expect(
          user, equals(Left(AuthenticationFailure(message: 'Saving failed'))));
    });
  });
}

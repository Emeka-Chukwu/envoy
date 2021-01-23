import 'package:dartz/dartz.dart';
import 'package:envoy/cores/error/failures.dart';
import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
import 'package:envoy/features/Authentication/presentation/bloc/auths_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mock/mock.dart';

void main() {
  UserEntity userEntity;
  AuthsBloc authBloc;
  MockUserCredential mockUserCredential;
  MockAuthenticationRepository mockAuthenticationRepository;
  MockFireBaseUser mockFireBaseUser;

  setUp(() {
    userEntity = userEntityData();
    mockFireBaseUser = MockFireBaseUser();
    mockUserCredential = MockUserCredential();
    mockAuthenticationRepository = MockAuthenticationRepository();
    authBloc = AuthsBloc(
        initialState: AuthsInitial(), repository: mockAuthenticationRepository);
  });

  group("Auths sign up event", () {
    test(
        "should emit [Authenticating] and [Authenticated] when sign up and save is complete",
        () async {
      when(mockAuthenticationRepository.registerUser(any))
          .thenAnswer((_) => Future.value(Right(mockUserCredential)));
      when(mockUserCredential.user).thenReturn(mockFireBaseUser);
      when(mockFireBaseUser.uid).thenReturn("userId");
      when(mockAuthenticationRepository.saveTODatabase(any))
          .thenAnswer((realInvocation) => Future.value(Right(true)));
      final expected = [
        Authenticating(),
        Authenticated(),
      ];
      expectLater(authBloc, emitsInOrder(expected));
      authBloc.add(RegisterEvent(userEntity: userEntity));
    });

    test(
        "should emit [Authenticating] and [AuthsError] when user fails to sign up",
        () {
      when(mockAuthenticationRepository.registerUser(any))
          .thenAnswer((_) => Future.value(Left(AuthenticationFailure())));

      final expected = [
        Authenticating(),
        AuthsError(),
      ];

      expectLater(authBloc, emitsInOrder(expected));
      authBloc.add(RegisterEvent(userEntity: userEntity));
    });

    test(
        "should emit [Authenicating] and [AuthError] when a user registers but the details failed to save",
        () async {
      when(mockAuthenticationRepository.registerUser(any))
          .thenAnswer((_) => Future.value(Right(mockUserCredential)));
      when(mockUserCredential.user).thenReturn(mockFireBaseUser);
      when(mockFireBaseUser.uid).thenReturn("userId");
      when(mockAuthenticationRepository.saveTODatabase(any))
          .thenAnswer((_) => Future.value(Left(AuthenticationFailure())));

      final expected = [
        Authenticating(),
        AuthsError(message: "unable to save user details"),
      ];

      expectLater(authBloc, emitsInOrder(expected));
      authBloc.add(RegisterEvent(userEntity: userEntity));
    });
  });

  group("Login bloc logic", () {
    test(
        "should return state [Authenticating] and [Authenticated] when sign in is done",
        () {
      when(mockAuthenticationRepository.loginUser(any))
          .thenAnswer((_) => Future.value(Right(mockUserCredential)));

      final expected = [
        Authenticating(),
        Authenticated(userEntity: userEntity)
      ];

      expectLater(authBloc, emitsInOrder(expected));
      authBloc.add(LoginEvent(userEntity: userEntity));
    });

    test(
        "should return state [Authenticating] and [AuthsError] when signin failed",
        () {
      when(mockAuthenticationRepository.loginUser(any)).thenAnswer(
          (realInvocation) => Future.value(
              Left(AuthenticationFailure(message: "signin failed"))));

      final expected = [
        Authenticating(),
        AuthsError(message: "signed In failed"),
      ];

      expectLater(authBloc, emitsInOrder(expected));
      authBloc.add(LoginEvent(userEntity: userEntity));
    });
  });

  group("test for initial state od th application and others", () {
    test("should return Initial state of the application [AuthsInitial]", () {
      expect(authBloc.state, equals(AuthsInitial()));
    });

    test("should check if the logout is clicked", () async {
      authBloc.add(LogOut());
      await untilCalled(mockAuthenticationRepository.logout());
      verify(mockAuthenticationRepository.logout());
    });
  });
}

// import 'package:dartz/dartz.dart';
// import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
// import 'package:envoy/features/Authentication/presentation/bloc/auths_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../../../fixtures/fixture_reader.dart';
// import '../../../../mock/mock.dart';

// void main() {
//   UserEntity userEntity;
//   AuthsBloc authBloc;
//   MockUserCredential mockUserCredential;
//   MockAuthenticationRepository mockUserRepository;
//   MockFireBaseUser fireBaseUser;

//   setUp(() {
//     userEntity = userEntityData();
//     fireBaseUser = MockFireBaseUser();
//     mockUserCredential = MockUserCredential();
//     mockUserRepository = MockAuthenticationRepository();
//     authBloc = AuthsBloc(
//       initialState: AuthsInitial(),
//       repository: mockUserRepository,
//     );
//   });

// group('Auth bloc Sign up event', () {
//   test(
//       'should emit [Authinprogress] and [Authcomplete] when sign up and save is successful',
//       () async {
//     when(mockUserRepository.registerUser(any)).thenAnswer(
//       (_) => Future.value(Right(mockUserCredential)),
//     );
//     when(mockUserCredential.user).thenReturn(fireBaseUser);
//     when(fireBaseUser.uid).thenReturn('userId');
//     when(mockUserRepository.saveTODatabase(any)).thenAnswer(
//       (_) => Future.value(Right(true)),
//     );
//     final expected = [
//       Authenticating,
//       Authenticated,
//     ];
//     expectLater(authBloc, emitsInOrder(expected));

//     authBloc.add(RegisterEvent(userEntity: userEntity));
//   });
// });

// test('should emit [Authinprogress] and [Authfailed] when sign up fails',
//     () async {
//   when(mockUserRepository.signUpNewUser(any)).thenAnswer(
//     (_) => Future.value(Left(AuthFailure(message: 'Sign up failed'))),
//   );
//   final expected = [
//     AuthInProgress(),
//     AuthFailed(message: 'Sign up failed'),
//   ];
//   expectLater(authBloc, emitsInOrder(expected));

//   authBloc.add(SignUp(user: userEntity));
// });

// test('should emit [AuthFailed] when user details fails to save', () async {
//   when(mockUserRepository.signUpNewUser(any)).thenAnswer(
//     (_) => Future.value(Right(mockUserCredential)),
//   );
//   when(mockUserCredential.user).thenReturn(fireBaseUser);
//   when(fireBaseUser.uid).thenReturn('userId');
//   when(mockUserRepository.saveUserDetail(any))
//       .thenAnswer(
//     (_) =>
//         Future.value(Left(AuthFailure(message: 'Saving details failed'))),
//   );
//   final expected = [
//     AuthInProgress(),
//     AuthFailed(message: 'Saving details failed'),
//   ];
//   expectLater(authBloc, emitsInOrder(expected));

//   authBloc.add(SignUp(user: userEntity));
// });

// group('Auth bloc Log in event', () {
//   test(
//       'should emit [Authinprogress] and [Authcomplete] when log in is successful',
//       () async {
//     when(mockUserRepository.logInUser(any)).thenAnswer(
//       (_) => Future.value(Right(mockUserCredential)),
//     );
//     final expected = [
//       AuthInProgress(),
//       AuthComplete(),
//     ];
//     expectLater(authBloc, emitsInOrder(expected));

//     authBloc.add(Login(user: userEntity));
//   });

//   test('should emit [Authinprogress] and [Authfailed] when log in fails',
//       () async {
//     when(mockUserRepository.logInUser(any)).thenAnswer(
//       (_) => Future.value(Left(AuthFailure(message: 'Sign up failed'))),
//     );
//     final expected = [
//       AuthInProgress(),
//       AuthFailed(message: 'Sign up failed'),
//     ];
//     expectLater(authBloc, emitsInOrder(expected));

//     authBloc.add(Login(user: userEntity));
//   });
// });

// group('others', () {
//   test(('confirm inistial bloc state'), () {
//     expect(authBloc.state, equals(InitialAuthState()));
//   });

//   test(('confirm log out is called for log out event'), () async {
//     authBloc.add(LogOut());
//     await untilCalled(mockUserRepository.logOutUser());
//     verify(mockUserRepository.logOutUser());
//   });
// });
// }

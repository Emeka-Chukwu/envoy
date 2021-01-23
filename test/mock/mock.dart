import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envoy/features/Authentication/domain/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mockito/mockito.dart';

// Repositories

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

// Externals
class MockCollectionReference extends Mock implements CollectionReference {}

class MockQuery extends Mock implements Query {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

class MockReference extends Mock implements Reference {}

class MockUserCredential extends Mock implements UserCredential {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockFireBaseAuth extends Mock implements FirebaseAuth {}

class MockFireBaseUser extends Mock implements User {}

class MockDocumentReference extends Mock implements DocumentReference {}

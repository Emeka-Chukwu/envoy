import 'package:envoy/features/Authentication/data/model/user_model.dart';
import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';

UserModel userModelData() => UserModel(
      password: "123456",
      email: "emeka@gmail.com",
      city: "Agbara",
      state: "Ogun",
      country: "Nigeria",
      hAddress: "My recent address boss",
    );

UserModel userModelData2() => UserModel(
      password: "12345",
      email: "emeka@gmail.com",
      city: "Agbara",
      state: "Ogun",
      country: "Nigeria",
      hAddress: "My recent address boss",
    );

UserEntity userEntityData() => UserEntity(
      password: "123456",
      email: "emeka@gmail.com",
      city: "Agbara",
      state: "Ogun",
      country: "Nigeria",
      hAddress: "My recent address boss",
    );

import 'package:envoy/features/Authentication/domain/entity/user_entity.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends UserEntity {
  final String id;
  final String fName;
  final String lName;
  final String password;
  final String country;
  final String state;
  final String city;
  final String hAddress;
  final String email;

  UserModel({
    this.id,
    this.fName,
    this.lName,
    @required this.password,
    this.country,
    this.state,
    this.city,
    this.hAddress,
    @required this.email,
  }) : super(
          fName: fName,
          lName: lName,
          password: password,
          email: email,
          state: state,
          city: city,
          hAddress: hAddress,
        );

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      password: userEntity.password,
      email: userEntity.email,
      fName: userEntity.fName,
      lName: userEntity.lName,
      country: userEntity.country,
      city: userEntity.city,
      hAddress: userEntity.hAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      'lName': this.lName,
      "fName": this.fName,
      "email": this.email,
      "country": this.country,
      "city": this.city,
      'hAddress': this.hAddress,
      "state": this.state,
    };
  }
}

class UserEntity {
  String id;
  final String fName;
  final String lName;
  final String password;
  final String country;
  final String state;
  final String city;
  final String hAddress;
  final String email;

  UserEntity({
    this.id,
    this.fName,
    this.lName,
    this.password,
    this.country,
    this.state,
    this.city,
    this.hAddress,
    this.email,
  });

  @override
  List<Object> get props =>
      [id, fName, lName, password, country, state, city, hAddress];
}

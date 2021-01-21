class ProfileEntity {
  final String fName;
  final String lName;
  final String password;
  final String country;
  final String state;
  final String city;
  final String hAddress;

  ProfileEntity(this.fName, this.lName, this.password, this.country, this.state,
      this.city, this.hAddress);

  @override
  List<Object> get props =>
      [fName, lName, password, country, state, city, hAddress];
}

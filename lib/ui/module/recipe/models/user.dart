class User {
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String image;

  User(
      {this.id, this.fname, this.lname, this.email, this.password, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      image: json['image'] as String,
    );
  }
}

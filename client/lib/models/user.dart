class User {
  final String username;
  final String password;
  User({
    this.username = "",
    this.password = "",
  });

  factory User.fromJson(Map? json) {
    if (json == null) {
      return User(username: "", password: "");
    }
    return User(username: json['username'], password: json['password']);
  }
}

class User {
  String username;
  String password;
  int expiresInMins = 30;
  User({required this.username, required this.password});

  // toJson metodu
  Map<dynamic, dynamic> toJson() {
    return {'username': username, 'password': password, 'expiresInMins': 30};
  }
}

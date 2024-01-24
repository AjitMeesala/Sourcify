class UserCred {
  final String email;
  final String password;

  UserCred({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
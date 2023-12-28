class User {
  final String name;
  final String mobile;
  final String email;
  final String password;

  User({
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'mobile': mobile,
    'email': email,
    'password': password,
  };
}
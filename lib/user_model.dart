class User {
  final int id;
  final String username;
  final String password; // Note: It's not recommended to store passwords in plain text in your app
  final String email;
  final String phone;
  final String role;
  final String createdAt;
  final String building;
  final String unit;
  final String apartment;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.role,
    required this.createdAt,
    required this.building,
    required this.unit,
    required this.apartment,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
      building: json['building'] ?? '',
      unit: json['unit'] ?? '',
      apartment: json['apartment'] ?? '',
    );
  }
}

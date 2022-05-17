class Student {
  Student({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.password,
  });

  String id;
  String name;
  String username;
  String email;
  String address;
  String password;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address,
        'password': password,
      };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        address: json['address'] as String,
        password: json['password'] as String,
      );
}

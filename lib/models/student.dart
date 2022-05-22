class Student {
  Student({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.gradeLevel,
    required this.howMayWeHelpYou,
    required this.address,
    required this.contact,
    required this.password,
  });

  String id;
  String name;
  String username;
  String email;
  String gradeLevel;
  String howMayWeHelpYou;
  String address;
  String contact;
  String password;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'address': address,
        'contact': contact,
        'grade_level': gradeLevel,
        'how_may_we_help_you': howMayWeHelpYou,
        'password': password,
      };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        address: json['address'] as String,
        contact: json['contact'] as String,
        gradeLevel: json['grade_level'] as String,
        howMayWeHelpYou: json['how_may_we_help_you'] as String,
        password: json['password'] as String,
      );
}

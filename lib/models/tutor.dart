class Tutor {
  Tutor({
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.socialMediaUrl,
    required this.shortBio,
    required this.password,
  });

  String name;
  String username;
  String email;
  String address;
  String socialMediaUrl;
  String shortBio;
  String password;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'username': username,
        'email': email,
        'address': address,
        'social_media_url': socialMediaUrl,
        'short_bio': shortBio,
        'password': password,
      };

  factory Tutor.fromJson(Map<String, dynamic> json) => Tutor(
        name: json['name'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        address: json['address'] as String,
        socialMediaUrl: json['social_media_url'] as String,
        shortBio: json['short_bio'] as String,
        password: json['password'] as String,
      );
}

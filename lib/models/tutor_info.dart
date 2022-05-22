class TutorInfo {
  TutorInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.tutor_id,
    required this.availability,
    required this.ratePerHour,
  });
  String id;
  String name;
  String address;
  String tutor_id;
  bool availability;
  String ratePerHour;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'address': address,
        'tutor_id': tutor_id,
        'availability': availability,
        'rate_per_hour': ratePerHour,
      };

  factory TutorInfo.fromJson(Map<String, dynamic> json) => TutorInfo(
        id: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        tutor_id: json['tutor_id'] as String,
        availability: json['availability'] as bool,
        ratePerHour: json['rate_per_hour'] as String,
      );
}

class StudentBooking {
  StudentBooking({
    required this.id,
    required this.name,
    required this.studentId,
    required this.tutorId,
    required this.status,
  });

  String id;
  String name;
  String studentId;
  String tutorId;
  String status;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'student_id': studentId,
        'tutor_id': tutorId,
        'status': status,
      };

  factory StudentBooking.fromJson(Map<String, dynamic> json) => StudentBooking(
        id: json['id'] as String,
        name: json['name'] as String,
        studentId: json['student_id'] as String,
        tutorId: json['tutor_id'] as String,
        status: json['status'] as String,
      );
}

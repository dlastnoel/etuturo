class Rating {
  Rating({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.tutorId,
    required this.rating,
    required this.feedback,
  });

  String id;
  String studentId;
  String studentName;
  String tutorId;
  double rating;
  String feedback;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'student_id': studentId,
        'student_name': studentName,
        'tutor_id': tutorId,
        'rating': rating,
        'feedback': feedback,
      };

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json['id'] as String,
        studentId: json['student_id'] as String,
        studentName: json['student_name'] as String,
        tutorId: json['tutor_id'] as String,
        rating: json['rating'] as double,
        feedback: json['feedback'] as String,
      );
}

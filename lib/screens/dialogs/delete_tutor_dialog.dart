import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/configs/eula.dart';
import 'package:etuturo_app/models/student.dart';
import 'package:etuturo_app/models/tutor.dart';
import 'package:etuturo_app/models/tutor_info.dart';
import 'package:etuturo_app/screens/login_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

deleteTutorData(String tutorId) async {
  List<DocumentSnapshot> tutorInfos = [];
  List<DocumentSnapshot> studentBookings = [];
  List<DocumentSnapshot> ratings = [];

  final tutorDoc =
      await FirebaseFirestore.instance.collection('tutors').doc(tutorId);
  tutorDoc.delete();
  final tutorInfoDocs = await FirebaseFirestore.instance
      .collection('tutor_info')
      .where('tutor_id', isEqualTo: tutorId)
      .get();
  tutorInfos = tutorInfoDocs.docs;

  final studentBookingDocs = await FirebaseFirestore.instance
      .collection('student_booking')
      .where('tutor_id', isEqualTo: tutorId)
      .get();
  studentBookings = studentBookingDocs.docs;

  final ratingDocs = await FirebaseFirestore.instance
      .collection('ratings')
      .where('tutor_id', isEqualTo: tutorId)
      .get();
  ratings = ratingDocs.docs;

  tutorDoc.delete();
  for (int i = 0; i < tutorInfos.length; i++) {
    final tutorInfo = await FirebaseFirestore.instance
        .collection('tutor_info')
        .doc(tutorInfos[i]['id']);
    tutorInfo.delete();
  }
  for (int i = 0; i < studentBookings.length; i++) {
    final studentBooking = await FirebaseFirestore.instance
        .collection('student_booking')
        .doc(studentBookings[i]['id']);
    studentBooking.delete();
  }
  for (int i = 0; i < ratings.length; i++) {
    final rating = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(ratings[i]['id']);
    rating.delete();
  }
}

Future deleteTutorDialog(context, String tutorId) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text('Before you proceed:'),
          content: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.height) -
                    ((MediaQuery.of(context).size.height) * 0.75),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        'Are you sure you want to delete your account? Action taken will be irreversible.',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                deleteTutorData(tutorId);
                Fluttertoast.showToast(msg: 'Account successfully deleted');
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
            )
          ],
        );
      });
    },
  );
}

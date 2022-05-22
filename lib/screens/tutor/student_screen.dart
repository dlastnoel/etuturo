import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/models/student_booking.dart';
import 'package:etuturo_app/preferences/booking_preferences.dart';
import 'package:etuturo_app/screens/tutor/tutor_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class StudentScreen extends StatefulWidget {
  StudentScreen({
    Key? key,
    required this.studentBookingId,
    required this.studentId,
    required this.tutorId,
  }) : super(key: key);
  final String studentBookingId;
  final String studentId;
  final String tutorId;

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<DocumentSnapshot> documents = [];
  String _studentName = '';
  String _email = '';
  String _address = '';
  String _contact = '';
  String _gradeLevel = '';
  String _query = '';

  initAppointments() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('student_booking')
        .where('tutor_id', isEqualTo: widget.tutorId)
        .where('status', isEqualTo: 'pending')
        .get();
    setState(() {
      documents = result.docs;
    });
  }

  initStudent() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('students')
        .where('id', isEqualTo: widget.studentId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      _studentName = documents.first.get('name');
      _email = documents.first.get('email');
      _address = documents.first.get('address');
      _contact = documents.first.get('contact');
      _gradeLevel = documents.first.get('grade_level');
      _query = documents.first.get('how_may_we_help_you');
    });
  }

  deleteStudentBooking() async {
    List<DocumentSnapshot> docs = [];
    final studentBookingDocs = await FirebaseFirestore.instance
        .collection('student_booking')
        .where('id', isNotEqualTo: widget.studentBookingId)
        .where('tutor_id', isEqualTo: widget.tutorId)
        .get();
    docs = studentBookingDocs.docs;
    for (int i = 0; i < docs.length; i++) {
      await FirebaseFirestore.instance
          .collection('student_booking')
          .doc(docs[i]['id'])
          .delete();
    }
  }

  acceptBooking() {
    final studentBooking =
        FirebaseFirestore.instance.collection('student_booking');
    studentBooking.doc(widget.studentBookingId).update({
      'status': 'ongoing',
    }).then((value) {
      Fluttertoast.showToast(msg: 'Student accepted as tutor');
    }).catchError((error) => print('Failed: $error'));
  }

  updateStatus(bool status) async {
    final tutorInfoDoc = FirebaseFirestore.instance.collection('tutor_info');
    tutorInfoDoc
        .doc(widget.tutorId)
        .update({
          'availability': status,
        })
        .then((value) {})
        .catchError((error) => print('Failed: $error'));
  }

  @override
  void initState() {
    initStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/head.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hi! I am ${_studentName}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(
                    image: AssetImage('assets/images/tutuser.png'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      'ACCEPT STUDENT',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          deleteStudentBooking();
                          updateStatus(false);
                          acceptBooking();
                          Fluttertoast.showToast(
                              msg: 'Student accepted',
                              toastLength: Toast.LENGTH_LONG);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TutorDashboardScreen(
                                    tutorId: widget.tutorId),
                              ),
                              (route) => false);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Student Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.tealAccent.shade700,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email: ${_email}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Address: ${_address}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Contact: ${_contact}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Grade Level: ${_gradeLevel}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Query: ${_query}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

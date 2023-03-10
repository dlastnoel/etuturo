import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/preferences/appointment_preferences.dart';
import 'package:etuturo_app/screens/login_screen.dart';
import 'package:etuturo_app/screens/student/list_of_tutors.dart';
import 'package:etuturo_app/screens/student/rate_tutor_screen.dart';
import 'package:etuturo_app/screens/student/student_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDashboardScreen extends StatefulWidget {
  StudentDashboardScreen({
    Key? key,
    required this.studentId,
  }) : super(key: key);
  final String studentId;

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  final _appointmentPreferences = AppointmentPreferences();
  String _studentId = '';
  String _studentName = '';
  initStudent() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('students')
        .where('id', isEqualTo: widget.studentId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      _studentId = documents.first.get('id');
      _studentName = documents.first.get('name');
    });
  }

  bool _hasAppointment = false;
  bool _booked = false;

  initHasAppointment() async {
    _hasAppointment = await _appointmentPreferences.getAppointment();
    print('HAS APPOINTMENT' + _hasAppointment.toString());
    setState(() {
      if (_hasAppointment) {
        _booked = true;
      } else {
        _booked = false;
      }
    });
  }

  @override
  void initState() {
    // initHasAppointment();
    initStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Text(
                  'Student Dashboard',
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _studentName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          'List of Tutors',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 70, 0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListOfTutorsScreen(
                                  studentId: _studentId,
                                  studentName: _studentName),
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 50, 0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentProfileScreen(studentId: _studentId),
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 50, 0)),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:etuturo_app/models/database_model.dart';
import 'package:etuturo_app/screens/student/rating_screen.dart';
import 'package:etuturo_app/screens/student/student_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginStudentScreen extends StatefulWidget {
  const LoginStudentScreen({Key? key}) : super(key: key);

  @override
  State<LoginStudentScreen> createState() => _LoginStudentScreenState();
}

class _LoginStudentScreenState extends State<LoginStudentScreen> {
  String _studentId = '';
  String _tutorId = '';
  String _studentBookingId = '';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // DatabaseModel databaseModel = DatabaseModel();

  Future<bool> studentExists(String email, String password) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    print(documents.length);
    return documents.length == 1;
  }

  Future<String> initStudent(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('students')
        .where('email', isEqualTo: email)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.first.get('id');
  }

  updateBookingStatus(String studentBookingId) async {
    final studentBooking =
        FirebaseFirestore.instance.collection('student_booking');
    studentBooking.doc(studentBookingId).update({
      'status': 'done',
    }).then((value) {
      // Navigator.pop(context);
    }).catchError((error) => print('Failed: $error'));
  }

  initAppointments(String studentId) async {
    List<DocumentSnapshot> documents = [];
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('student_booking')
        .where('student_id', isEqualTo: studentId)
        .where('status', isEqualTo: 'for_rating')
        .get();
    setState(() {
      documents = result.docs;
      // print('DOCS LENGTH: ' + documents.length.toString());
      if (documents.length > 0) {
        // _studentBookingId = documents.first.get('id');
        // _studentId = documents.first.get('student_id');
        // _tutorId = documents.first.get('tutor_id');
        updateBookingStatus(documents[0]['id']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RatingScreen(
              studentBookingId: documents[0]['id'],
              studentId: documents[0]['student_id'],
              studentName: documents[0]['name'],
              tutorId: documents[0]['tutor_id'],
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDashboardScreen(
              studentId: studentId,
            ),
          ),
        );
      }
    });
  }

  initControllers() {
    _emailController.text = 'markdelacruz07@gmail.com';
    _passwordController.text = '12345';
  }

  @override
  void initState() {
    // initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: SafeArea(
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
                        height: 15,
                      ),
                      const Text(
                        'Hello Student!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Image(
                        image: AssetImage('assets/images/pic2.png'),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(labelText: "Email"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          cursorColor: Colors.black,
                          decoration:
                              const InputDecoration(labelText: "Password"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent.shade700,
                          onPrimary: Colors.white, // f
                          fixedSize: const Size(150, 0),
                        ),
                        onPressed: () async {
                          if (_emailController.text != '' &&
                              _passwordController.text != '') {
                            bool exists = await studentExists(
                                _emailController.text,
                                _passwordController.text);
                            String studentId =
                                await initStudent(_emailController.text);
                            print('WORKING');
                            if (exists) {
                              initAppointments(studentId);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Email/Password is incorrect.',
                                  ),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please complete your credentials.',
                                ),
                              ),
                            );
                          }
                        },
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
        ),
      ),
    );
  }
}

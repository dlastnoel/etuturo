import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/models/student_booking.dart';
import 'package:etuturo_app/preferences/appointment_preferences.dart';
import 'package:etuturo_app/screens/sign_up_menu_screen.dart';
import 'package:etuturo_app/screens/student/tutor_screen.dart';
import 'package:etuturo_app/screens/tutor/student_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListofAppointmentsScreen extends StatefulWidget {
  ListofAppointmentsScreen({Key? key, required this.tutorId}) : super(key: key);
  final String tutorId;

  @override
  State<ListofAppointmentsScreen> createState() =>
      _ListofAppointmentsScreenState();
}

class _ListofAppointmentsScreenState extends State<ListofAppointmentsScreen> {
  List<DocumentSnapshot> documents = [];

  initAppointments() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('student_booking')
        .where('tutor_id', isEqualTo: widget.tutorId)
        .where('status', isEqualTo: 'pending')
        .get();
    setState(() {
      documents = result.docs;
      // print(widget.tutorId);
      // print(documents.length);
    });
  }

  initActiveAppointment() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('student_booking')
        .where('tutor_id', isEqualTo: widget.tutorId)
        .where('status', isEqualTo: 'ongoing')
        .get();
    setState(() {
      documents = result.docs;
      if (documents.length <= 0) {
        print(documents.length.toString());
        initAppointments();
      }
    });
  }

  deleteStudentBooking(String studentBookingId) async {
    List<DocumentSnapshot> docs = [];
    final studentBookingDocs = await FirebaseFirestore.instance
        .collection('student_booking')
        .where('id', isNotEqualTo: studentBookingId)
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

  acceptBooking(String studentBookingId) async {
    final studentBooking =
        FirebaseFirestore.instance.collection('student_booking');
    studentBooking.doc(studentBookingId).update({
      'status': 'ongoing',
    }).then((value) {
      Fluttertoast.showToast(msg: 'Student accepted as tutor');
      Navigator.pop(context);
    }).catchError((error) => print('Failed: $error'));
  }

  finishBooking(String studentBookingId) async {
    final studentBooking =
        FirebaseFirestore.instance.collection('student_booking');
    studentBooking
        .doc(studentBookingId)
        .update({
          'status': 'for_rating',
        })
        .then((value) {})
        .catchError((error) => print('Failed: $error'));
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
    initActiveAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return documents.length > 0
        ? hasAppointmentWidget()
        : noAppointmentWidget();
  }

  hasAppointmentWidget() {
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
                  height: 15,
                ),
                const Text(
                  'List of Appointments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 15,
                        color: Colors.tealAccent.shade700,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Card(
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name: ${documents[index]['name']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (documents[index]['status'] ==
                                      'pending') ...[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white,
                                          fixedSize: const Size(200, 30)),
                                      child: Text(
                                        'ACCEPT STUDENT',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        deleteStudentBooking(
                                            documents[index]['id']);
                                        acceptBooking(documents[index]['id']);
                                        updateStatus(false);
                                        Fluttertoast.showToast(
                                            msg: 'Student accepted',
                                            toastLength: Toast.LENGTH_LONG);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white,
                                          fixedSize: const Size(200, 30)),
                                      child: Text(
                                        'VIEW PROFILE',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StudentScreen(
                                                studentBookingId:
                                                    documents[index]['id'],
                                                studentId: documents[index]
                                                    ['student_id'],
                                                tutorId: widget.tutorId),
                                          ),
                                        );
                                      },
                                    )
                                  ] else ...[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                        fixedSize: const Size(200, 30),
                                      ),
                                      child: Text(
                                        'STATUS: ONGOING',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                        fixedSize: const Size(200, 30),
                                      ),
                                      child: Text(
                                        'END SESSION',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        finishBooking(documents[index]['id']);
                                        updateStatus(true);
                                        Fluttertoast.showToast(
                                            msg: 'Tutor session ended');
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: documents.length,
                  ),
                )
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
          ),
        ],
      ),
    );
  }

  noAppointmentWidget() {
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
                  height: 15,
                ),
                const Text(
                  'List of Appointments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'No incoming appointments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}

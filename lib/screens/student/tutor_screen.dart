import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/models/student_booking.dart';
import 'package:etuturo_app/preferences/booking_preferences.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TutorScreen extends StatefulWidget {
  TutorScreen({
    Key? key,
    required this.studentName,
    required this.tutorId,
    required this.studentId,
  }) : super(key: key);
  final String studentName;
  final String tutorId;
  final String studentId;

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  final _bookingPreferences = BookingPreferences();
  final _uuid = Uuid();
  double rating = 4.0;
  String _appointment = 'BOOK FOR APPOINTMENT';
  String _name = '';
  String _email = '';
  String _address = '';
  String _contact = '';
  String _socialMediaUrl = '';
  String _shortBio = '';
  String _tutorId = '';
  String _studentBookingId = '';
  String _status = '';

  bool _availability = false;
  String _ratePerHour = '';

  initTutor() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutors')
        .where('id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      _tutorId = documents.first.get('id');
      _name = documents.first.get('name');
      _email = documents.first.get('email');
      _address = documents.first.get('address');
      _contact = documents.first.get('contact');
      _socialMediaUrl = documents.first.get('social_media_url');
      _shortBio = documents.first.get('short_bio');
    });
  }

  initTutorInfo() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutor_info')
        .where('tutor_id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      _availability = documents.first.get('availability');
      _ratePerHour = documents.first.get('rate_per_hour');
    });
  }

  initStudentBooking() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('student_booking')
        .where('student_id', isEqualTo: widget.studentId)
        .where('tutor_id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length > 0) {
      setState(() {
        _studentBookingId = documents.first.get('student_id');
        _status = documents.first.get('status');
        if (documents.first.get('status') == ' pending') {
          _appointment = 'WAITING FOR APPROVAL';
        }
      });
    }
  }

  List<DocumentSnapshot> documents = [];
  List<DocumentSnapshot> studentDocs = [];
  initTutorRatings() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('ratings')
        .where('tutor_id', isEqualTo: widget.tutorId)
        .get();
    setState(() {
      documents = result.docs;
      double ratingTotal = 0;
      for (int i = 0; i < documents.length; i++) {
        ratingTotal += documents[i]['rating'];
      }
      rating = ratingTotal / documents.length;
    });
  }

  initStudentInfo(String studentId) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('students')
        .where('id', isEqualTo: widget.studentId)
        .get();
    setState(() {
      studentDocs = result.docs;
    });
  }

  addStudentBooking(StudentBooking studentBooking) async {
    final studentBookingDoc = await FirebaseFirestore.instance
        .collection('student_booking')
        .doc(studentBooking.id);
    await studentBookingDoc.set(studentBooking.toJson());
  }

  deleteStudentBooking() async {
    final studentBookingDoc = await FirebaseFirestore.instance
        .collection('student_booking')
        .doc(_studentBookingId);
    await studentBookingDoc.delete();
  }

  @override
  void initState() {
    initTutor();
    initTutorInfo();
    initStudentBooking();
    initTutorRatings();
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
                    'Hi! I am ${_name}. Here is my profile.',
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
                  if (_status != '' && (_status == 'pending')) ...[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        _appointment,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            if (_appointment == 'BOOK FOR APPOINTMENT') {
                              _studentBookingId = _uuid.v4();
                              StudentBooking studentBooking = StudentBooking(
                                  id: _studentBookingId,
                                  name: widget.studentName,
                                  studentId: widget.studentId,
                                  tutorId: _tutorId,
                                  status: 'pending');
                              addStudentBooking(studentBooking);
                              _appointment = 'WAITING FOR APPROVAL';
                            } else {
                              _appointment = 'BOOK FOR APPOINTMENT';
                              deleteStudentBooking();
                            }
                          },
                        );
                      },
                    ),
                  ] else ...[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        _appointment,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            if (_appointment == 'BOOK FOR APPOINTMENT') {
                              _studentBookingId = _uuid.v4();
                              StudentBooking studentBooking = StudentBooking(
                                  id: _studentBookingId,
                                  name: widget.studentName,
                                  studentId: widget.studentId,
                                  tutorId: _tutorId,
                                  status: 'pending');
                              addStudentBooking(studentBooking);
                              _appointment = 'WAITING FOR APPROVAL';
                            } else {
                              _appointment = 'BOOK FOR APPOINTMENT';
                              deleteStudentBooking();
                            }
                          },
                        );
                      },
                    ),
                  ],
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Tutor Information',
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
                          'Social Media Url: ${_socialMediaUrl}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rate per hour: ${_ratePerHour}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Short Bio: ${_shortBio}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Social Media Url: ${_socialMediaUrl}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (documents.length > 0) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Ratings and Reviews',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SmoothStarRating(
                      rating: rating,
                      isReadOnly: true,
                      size: 30,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      starCount: 5,
                      allowHalfRating: true,
                      spacing: 2.0,
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
                        children: documents.map(
                          (doc) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmoothStarRating(
                                    rating: doc['rating'],
                                    isReadOnly: true,
                                    size: 20,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    defaultIconData: Icons.star_border,
                                    starCount: 5,
                                    allowHalfRating: true,
                                    spacing: 2.0,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    'Name: ${doc['student_name']}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${doc['feedback']}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ]
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

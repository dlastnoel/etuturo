import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/models/rating_model.dart';
import 'package:etuturo_app/preferences/appointment_preferences.dart';
import 'package:etuturo_app/screens/sign_up_menu_screen.dart';
import 'package:etuturo_app/screens/student/student_dashboard_screen.dart';
import 'package:etuturo_app/screens/student/tutor_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:uuid/uuid.dart';

class RatingScreen extends StatefulWidget {
  RatingScreen({
    Key? key,
    required this.studentBookingId,
    required this.studentId,
    required this.studentName,
    required this.tutorId,
  }) : super(key: key);
  final String studentBookingId;
  final String studentId;
  final String studentName;
  final String tutorId;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  List<DocumentSnapshot> documents = [];
  double _rating = 0;
  final _uuid = Uuid();
  final _feedbackController = TextEditingController();

  initTutor() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutors')
        .where('id', isEqualTo: widget.tutorId)
        .get();
    setState(() {
      documents = result.docs;
    });
  }

  addRating(Rating rating) async {
    final studentDoc =
        await FirebaseFirestore.instance.collection('ratings').doc(rating.id);
    await studentDoc.set(rating.toJson());
  }

  @override
  void initState() {
    initTutor();
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
                  height: 15,
                ),
                Text(
                  'Rate ${documents[0]['name']}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
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
                              SmoothStarRating(
                                rating: _rating,
                                isReadOnly: false,
                                size: 30,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                starCount: 5,
                                allowHalfRating: true,
                                spacing: 2.0,
                                onRated: (value) {
                                  setState(() {
                                    _rating = value;
                                  });
                                },
                              ),
                              TextField(
                                  controller: _feedbackController,
                                  decoration: InputDecoration(
                                    labelText: 'Feedback',
                                    hintText: 'Feedback',
                                  )),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  onPrimary: Colors.white,
                                ),
                                child: Text(
                                  'RATE',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  if (_feedbackController.text != '') {
                                    final String ratingId = _uuid.v4();
                                    Rating tutorRating = Rating(
                                        id: ratingId,
                                        studentId: widget.studentId,
                                        studentName: widget.studentName,
                                        tutorId: widget.tutorId,
                                        rating: _rating,
                                        feedback: _feedbackController.text);
                                    addRating(tutorRating);
                                    Fluttertoast.showToast(
                                        msg: 'Rate successful',
                                        toastLength: Toast.LENGTH_LONG);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentDashboardScreen(
                                                    studentId:
                                                        widget.studentId)),
                                        (route) => false);
                                  } else {}
                                },
                              )
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

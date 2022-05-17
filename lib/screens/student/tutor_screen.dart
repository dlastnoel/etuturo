import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/preferences/booking_preferences.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({
    Key? key,
    required this.tutorId,
  }) : super(key: key);
  final String tutorId;

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  final _bookingPreferences = BookingPreferences();
  var rating = 4.0;
  String _appointment = 'BOOK FOR APPOINTMENT';
  String _booking = '';
  String name = '';
  String email = '';
  String address = '';
  String socialMediaUrl = '';
  String shortBio = '';

  bool availability = false;
  String ratePerHour = '';

  initBooking() async {
    _booking = await _bookingPreferences.getBooking();
    setState(() {
      _appointment = _booking;
    });
  }

  initTutor() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutors')
        .where('id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      name = documents.first.get('name');
      email = documents.first.get('email');
      address = documents.first.get('address');
      socialMediaUrl = documents.first.get('social_media_url');
      shortBio = documents.first.get('short_bio');
    });
  }

  initTutorInfo() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutor_info')
        .where('tutor_id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      availability = documents.first.get('availability');
      ratePerHour = documents.first.get('rate_per_hour');
    });
  }

  @override
  void initState() {
    // initBooking();
    initTutor();
    initTutorInfo();
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
                    'Hi! I am ${name}. Here is my profile.',
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
                      _appointment,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_appointment == 'BOOK FOR APPOINTMENT') {
                          _appointment = 'WAITING FOR APPROVAL';
                          _bookingPreferences
                              .setBooking('WAITING FOR APPROVAL');
                        } else {
                          _appointment = 'BOOK FOR APPOINTMENT';
                          _bookingPreferences
                              .setBooking('BOOK FOR APPOINTMENT');
                        }
                      });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const TutorScreen(),
                      //   ),
                      // );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Personal Information',
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
                          'Email: ${email}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Address: ${address}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Social Media Url: ${socialMediaUrl}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Short Bio: I teach English and Science',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Social Media Url: ${socialMediaUrl}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
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
                    isReadOnly: false,
                    size: 30,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 2.0,
                    onRated: (value) {
                      print("rating value -> $value");
                      // print("rating value dd -> ${value.truncate()}");
                    },
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
                        const Text(
                          'Jane Doe:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'The tutor is great and is very patient. Good job! I learned a lot. Thank you so much!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Jane Doe:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'The tutor helped me a lot on my studies and has a high mastery of its expertise. Worth it!',
                          style: TextStyle(
                            fontSize: 15,
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

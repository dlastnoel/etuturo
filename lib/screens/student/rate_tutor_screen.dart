import 'package:etuturo_app/preferences/appointment_preferences.dart';
import 'package:etuturo_app/screens/sign_up_menu_screen.dart';
import 'package:etuturo_app/screens/student/tutor_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RateTutorScreen extends StatefulWidget {
  const RateTutorScreen({Key? key}) : super(key: key);

  @override
  State<RateTutorScreen> createState() => _RateTutorScreenState();
}

class _RateTutorScreenState extends State<RateTutorScreen> {
  final _appointmentPreferences = AppointmentPreferences();
  final _feedbackController = TextEditingController();
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
                const Text(
                  'Rate Form',
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
                                rating: 0,
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
                                  _appointmentPreferences.setAppointment(false);
                                  Fluttertoast.showToast(
                                      msg: 'Rate successful',
                                      toastLength: Toast.LENGTH_LONG);
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

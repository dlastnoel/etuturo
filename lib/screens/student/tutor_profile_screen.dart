import 'package:etuturo_app/screens/tutor/tutor_info_screen.dart';
import 'package:flutter/material.dart';

class TutorProfileScreen extends StatefulWidget {
  const TutorProfileScreen({Key? key}) : super(key: key);

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
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
                  'Tutor Dashboard',
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
                                      const TutorProfileScreen()));
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Information',
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
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TutorInfoScreen()));
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Appointments',
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent.shade700,
                      onPrimary: Colors.white,
                      fixedSize: const Size(150, 0)),
                  onPressed: () {},
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
    );
  }
}

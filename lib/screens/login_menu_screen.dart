import 'package:etuturo_app/screens/login_student_screen.dart';
import 'package:etuturo_app/screens/login_tutor_screen.dart';
import 'package:flutter/material.dart';

class LoginMenuScreen extends StatefulWidget {
  const LoginMenuScreen({Key? key}) : super(key: key);

  @override
  State<LoginMenuScreen> createState() => _LoginMenuScreenState();
}

class _LoginMenuScreenState extends State<LoginMenuScreen> {
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
                const Image(
                  image: AssetImage('assets/images/woman.png'),
                ),
                ElevatedButton(
                  child: const Text(
                    'I am a Tutor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent.shade700,
                    onPrimary: Colors.white, // f
                    fixedSize: const Size(150, 0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginTutorScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Image(
                  image: AssetImage('assets/images/girl.png'),
                ),
                ElevatedButton(
                  child: const Text(
                    'I am a Student',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent.shade700,
                    onPrimary: Colors.white, // f
                    fixedSize: const Size(150, 0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginStudentScreen(),
                      ),
                    );
                  },
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
          )
        ],
      ),
    );
  }
}

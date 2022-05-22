import 'package:etuturo_app/screens/student/student_dashboard_screen.dart';
import 'package:etuturo_app/screens/student/tutor_screen.dart';
import 'package:etuturo_app/screens/tutor/student_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/screens/login_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const Etuturo());
}

class Etuturo extends StatelessWidget {
  const Etuturo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etuturo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginScreen(),
    );
  }
}

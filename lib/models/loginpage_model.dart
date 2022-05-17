// import 'package:etuturo_app/screens/student/sign_up_student_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../screens/student/student_dashboard_screen.dart';

// class LogInPage extends StatefulWidget {
//   const LogInPage({Key? key}) : super(key: key);

//   @override
//   State<LogInPage> createState() => LogInPageState();
// }

// class LogInPageState extends State<LogInPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return const StudentDashboardScreen();
//           } else {
//             return const SignupStudentScreen();
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:etuturo_app/screens/student/student_dashboard_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DatabaseModel {
//   signIn(emailController, passwordController, context) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       // sharePrefConfig.onboardingPageInfoController();
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => const StudentDashboardScreen()));
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case "invalid-email":
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 'Invalid email',
//               ),
//             ),
//           );
//           break;

//         case "user-not-found":
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('User not found'),
//             ),
//           );
//           break;

//         case "wrong-password":
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Invalid password'),
//             ),
//           );
//           break;

//         default:
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Please check your credentials and try again'),
//             ),
//           );
//       }
//     }
//   }
// }

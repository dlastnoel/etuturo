import 'package:etuturo_app/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginStudentScreen extends StatefulWidget {
  const LoginStudentScreen({Key? key}) : super(key: key);

  @override
  State<LoginStudentScreen> createState() => _LoginStudentScreenState();
}

class _LoginStudentScreenState extends State<LoginStudentScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  DatabaseModel databaseModel = DatabaseModel();

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: SafeArea(
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
                        height: 15,
                      ),
                      const Text(
                        'Hello!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Image(
                        image: AssetImage('assets/images/pic2.png'),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(labelText: "Email"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          cursorColor: Colors.black,
                          decoration:
                              const InputDecoration(labelText: "Password"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent.shade700,
                          onPrimary: Colors.white, // f
                          fixedSize: const Size(150, 0),
                        ),
                        onPressed: () {
                          databaseModel.signIn(
                              emailController, passwordController, context);
                          // print(emailController.text);
                          // print(passwordController.text);

                          // databarroller, passwordController, context);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const StudentDashboardScreen(),
                          //   ),
                          // );
                        },
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
        ),
      ),
    );
  }
}

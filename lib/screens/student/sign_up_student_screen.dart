import 'package:etuturo_app/models/database_model.dart';
import 'package:etuturo_app/screens/student/login_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupStudentScreen extends StatefulWidget {
  const SignupStudentScreen({Key? key}) : super(key: key);

  @override
  State<SignupStudentScreen> createState() => _SignupStudentScreenState();
}

class _SignupStudentScreenState extends State<SignupStudentScreen> {
  DatabaseModel databaseModel = DatabaseModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      height: 10,
                    ),
                    const Image(
                      image: AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Name',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: usernameController,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: "Username"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: "Email"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: addressController,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: "Address",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        // keyboardType: TextInputType.visiblePassword
                        controller: passwordController,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                      ),
                    ),
                    // Container(
                    //   margin:
                    //       const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    //   child: const TextField(
                    //     decoration: InputDecoration(
                    //         labelText: 'Confirm Password',
                    //         hintText: 'Confirm Password'),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.tealAccent.shade700,
                        onPrimary: Colors.white, // f
                        fixedSize: const Size(200, 0),
                      ),
                      onPressed: () async {
                        // databaseModel.signIn(
                        //     emailController, passwordController, context);
                        // print(emailController.text);
                        // print(passwordController.text);
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trimLeft());
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginStudentScreen()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "email-already-in-use") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Email already in use'),
                              ),
                            );
                          }

                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter a strong password'),
                              ),
                            );
                          }
                        }
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
    );
  }
}

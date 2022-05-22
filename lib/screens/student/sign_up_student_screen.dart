import 'package:cloud_firestore/cloud_firestore.dart';
import '../dialogs/sign_up_dialog.dart';
import 'package:etuturo_app/models/database_model.dart';
import 'package:etuturo_app/models/student.dart';
import 'package:etuturo_app/screens/login_screen.dart';
import 'package:etuturo_app/screens/student/login_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class SignupStudentScreen extends StatefulWidget {
  const SignupStudentScreen({Key? key}) : super(key: key);

  @override
  State<SignupStudentScreen> createState() => _SignupStudentScreenState();
}

class _SignupStudentScreenState extends State<SignupStudentScreen> {
  final _uuid = Uuid();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _gradeLevelController = TextEditingController();
  final _howMayWeHelpYouController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  addStudent(Student student) async {
    final studentDoc =
        await FirebaseFirestore.instance.collection('students').doc(student.id);
    await studentDoc.set(student.toJson());
  }

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
                      height: 10,
                    ),
                    const Text(
                      'Student Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: _nameController,
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
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Username',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          hintText: 'Address',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: _contactNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          hintText: 'Contact Number',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: _gradeLevelController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Grade Level',
                          hintText: 'Grade Level',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: _howMayWeHelpYouController,
                        decoration: const InputDecoration(
                          labelText: 'How may we help you?',
                          hintText: 'How may we help you?',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        // keyboardType: TextInputType.visiblePassword
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password',
                        ),
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
                        // try {
                        //   await FirebaseAuth.instance
                        //       .createUserWithEmailAndPassword(
                        //           email: emailController.text.trim(),
                        //           password: passwordController.text.trimLeft());
                        //   Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const LoginStudentScreen()));
                        // } on FirebaseAuthException catch (e) {
                        //   if (e.code == "email-already-in-use") {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text('Email already in use'),
                        //       ),
                        //     );
                        //   }

                        //   if (e.code == 'weak-password') {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text('Enter a strong password'),
                        //       ),
                        //     );
                        //   }
                        // }
                        if (_nameController.text != '' &&
                            _usernameController.text != '' &&
                            _emailController.text != '' &&
                            _addressController.text != '' &&
                            _howMayWeHelpYouController.text != '' &&
                            _gradeLevelController.text != '' &&
                            _passwordController.text != '' &&
                            _confirmPasswordController.text != '') {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            final studentId = _uuid.v4();
                            Student student = Student(
                                id: studentId,
                                name: _nameController.text,
                                username: _usernameController.text,
                                email: _emailController.text,
                                address: _addressController.text,
                                contact: _contactNumberController.text,
                                gradeLevel: _gradeLevelController.text,
                                howMayWeHelpYou:
                                    _howMayWeHelpYouController.text,
                                password: _passwordController.text);
                            // addStudent(student);
                            studentSignupDialog(context, student);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Email/Password is incorrect.',
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please complete your credentials.',
                              ),
                            ),
                          );
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

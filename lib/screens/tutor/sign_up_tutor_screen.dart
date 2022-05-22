import '../dialogs/sign_up_dialog.dart';
import 'package:etuturo_app/models/tutor_info.dart';
import 'package:etuturo_app/preferences/login_preferences.dart';
import 'package:etuturo_app/screens/login_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import '../../models/tutor.dart';

class SignupTutorScreen extends StatefulWidget {
  const SignupTutorScreen({Key? key}) : super(key: key);

  @override
  State<SignupTutorScreen> createState() => _SignupTutorScreenState();
}

class _SignupTutorScreenState extends State<SignupTutorScreen> {
  final _uuid = Uuid();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _socialMediaUrlController = TextEditingController();
  final _shortBioController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<bool> tutorExists(String username) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutors')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

  addTutor(Tutor tutor, TutorInfo tutorInfo) async {
    final tutorDoc =
        await FirebaseFirestore.instance.collection('tutors').doc(tutor.id);
    await tutorDoc.set(tutor.toJson());
    await addTutorInfo(tutorInfo, tutor.id);
  }

  addTutorInfo(TutorInfo tutorInfo, tutorInfoId) async {
    final tutorInfoDoc = await FirebaseFirestore.instance
        .collection('tutor_info')
        .doc(tutorInfo.id);
    await tutorInfoDoc.set(tutorInfo.toJson());
  }

  initData() {
    _nameController.text = 'John Doe';
    _usernameController.text = 'johndoe';
    _emailController.text = 'johndoe@gmail.com';
    _addressController.text = 'City of San Fernando, La Union';
    _socialMediaUrlController.text = 'www.facebook.com/johndoe';
    _shortBioController.text = 'I teach English and Science';
    _contactNumberController.text = '09123456789';
    _passwordController.text = '12345';
    _confirmPasswordController.text = '12345';
  }

  @override
  void initState() {
    // initData();
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
                  const Image(
                    image: AssetImage('assets/images/user.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Tutor Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        hintText: 'Address',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _socialMediaUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Social Media Url',
                        hintText: 'Social Media Url',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _shortBioController,
                      decoration: const InputDecoration(
                        labelText: 'Short Bio',
                        hintText: 'Short Bio',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Sign up',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent.shade700,
                      onPrimary: Colors.white, // f
                      fixedSize: const Size(200, 0),
                    ),
                    onPressed: () async {
                      if (_nameController.text != '' &&
                          _usernameController.text != '' &&
                          _emailController.text != '' &&
                          _addressController.text != '' &&
                          _contactNumberController.text != '' &&
                          _socialMediaUrlController.text != '' &&
                          _shortBioController.text != '' &&
                          _passwordController.text != '' &&
                          _confirmPasswordController.text != '') {
                        if (_passwordController.text ==
                            _confirmPasswordController.text) {
                          bool exists =
                              await tutorExists(_usernameController.text);
                          if (!exists) {
                            final tutorId = _uuid.v4();
                            final tutorInfoId = _uuid.v4();
                            Tutor tutor = Tutor(
                                id: tutorId,
                                name: _nameController.text,
                                username: _usernameController.text,
                                email: _emailController.text,
                                address: _addressController.text,
                                contact: _contactNumberController.text,
                                socialMediaUrl: _socialMediaUrlController.text,
                                shortBio: _shortBioController.text,
                                password: _passwordController.text);
                            TutorInfo tutorInfo = TutorInfo(
                              id: tutorInfoId,
                              name: _nameController.text,
                              address: _addressController.text,
                              tutor_id: tutor.id,
                              availability: false,
                              ratePerHour: '0',
                            );
                            tutorSignupDialog(context, tutor, tutorInfo);
                          }
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
    );
  }
}

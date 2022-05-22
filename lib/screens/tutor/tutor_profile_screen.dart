import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TutorProfileScreen extends StatefulWidget {
  TutorProfileScreen({
    Key? key,
    required this.tutorId,
  }) : super(key: key);
  final String tutorId;

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _socialMediaUrlController = TextEditingController();
  final _shortBioController = TextEditingController();

  initTutor() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutors')
        .where('id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      _nameController.text = documents.first.get('name');
      _emailController.text = documents.first.get('email');
      _addressController.text = documents.first.get('address');
      _contactNumberController.text = documents.first.get('contact');
      _socialMediaUrlController.text = documents.first.get('social_media_url');
      _shortBioController.text = documents.first.get('short_bio');
    });
  }

  @override
  void initState() {
    initTutor();
    super.initState();
  }

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
                  'Tutor Profile',
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
                      labelText: 'Short Bio',
                      hintText: 'Short Bio',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text(
                    'Update Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent.shade700,
                      onPrimary: Colors.white,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 50, 0)),
                  onPressed: () {
                    final _tutorInfoCollection =
                        FirebaseFirestore.instance.collection('tutors');
                    _tutorInfoCollection.doc(widget.tutorId).update({
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'address': _addressController.text,
                      'contact': _contactNumberController.text,
                      'social_media_url': _socialMediaUrlController.text,
                      'short_bio': _shortBioController.text
                    }).then((value) {
                      Fluttertoast.showToast(msg: 'Info successfully updated');
                      Navigator.pop(context);
                    }).catchError((error) => print('Failed: $error'));
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

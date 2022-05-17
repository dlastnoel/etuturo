import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudentProfileScreen extends StatefulWidget {
  StudentProfileScreen({
    Key? key,
    required this.studentId,
  }) : super(key: key);
  final String studentId;

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  initStudent() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('students')
        .where('id', isEqualTo: widget.studentId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      _nameController.text = documents.first.get('name');
      _emailController.text = documents.first.get('email');
      _addressController.text = documents.first.get('address');
    });
  }

  @override
  void initState() {
    // _nameController.text = 'Mark Dela Cruz';
    // _emailController.text = 'markdelacruz07@gmail.com';
    // _addressController.text = 'San Juan, La Union';
    initStudent();
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
                  'Student Profile',
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
                        FirebaseFirestore.instance.collection('students');
                    _tutorInfoCollection.doc(widget.studentId).update({
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'address': _addressController.text,
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

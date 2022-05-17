import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/screens/sign_up_menu_screen.dart';
import 'package:etuturo_app/screens/student/tutor_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_profile_screen.dart';
import 'package:flutter/material.dart';

class ListOfTutorsScreen extends StatefulWidget {
  const ListOfTutorsScreen({Key? key}) : super(key: key);

  @override
  State<ListOfTutorsScreen> createState() => _ListOfTutorsScreenState();
}

class _ListOfTutorsScreenState extends State<ListOfTutorsScreen> {
  List<DocumentSnapshot> documents = [];
  initTutors() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('tutors').get();
    setState(() {
      documents = result.docs;
    });
  }

  @override
  void initState() {
    initTutors();
    print(documents.length);
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
                  height: 15,
                ),
                const Text(
                  'List of Tutors',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 15,
                        color: Colors.tealAccent.shade700,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Card(
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      documents[index]['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      documents[index]['address'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        onPrimary: Colors.white,
                                      ),
                                      child: Text(
                                        'VIEW PROFILE',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TutorScreen(
                                                tutorId: documents[index]
                                                    ['id']),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                    itemCount: documents.length,
                  ),
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
          ),
        ],
      ),
    );
  }
}

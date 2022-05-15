import 'package:etuturo_app/screens/tutor/tutor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfTutorsScreen extends StatefulWidget {
  const ListOfTutorsScreen({Key? key}) : super(key: key);

  @override
  State<ListOfTutorsScreen> createState() => _ListOfTutorsScreenState();
}

class _ListOfTutorsScreenState extends State<ListOfTutorsScreen> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('tutors')
      .doc('tutors_list')
      .collection('tutors');

  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: ref.snapshots(),
              builder: (context, snapshot) {
                snapshot.data?.docs.forEach((doc) => {data = doc.data()});
                print(data);
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) => Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name: ${data['name']}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Address: ${data['address']}',
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
                                              builder: (context) =>
                                                  const TutorProfileScreen(),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ));
              }),
        ),
      ],
    ));
  }
}

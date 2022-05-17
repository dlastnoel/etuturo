import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/models/tutor.dart';
import 'package:etuturo_app/screens/login_screen.dart';
import 'package:etuturo_app/screens/tutor/appointment_list.dart';
import 'package:etuturo_app/screens/tutor/tutor_info_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TutorDashboardScreen extends StatefulWidget {
  const TutorDashboardScreen({
    Key? key,
    required this.tutorId,
  }) : super(key: key);
  final String tutorId;

  @override
  State<TutorDashboardScreen> createState() => _TutorDashboardScreenState();
}

class _TutorDashboardScreenState extends State<TutorDashboardScreen> {
  String tutorId = '';
  String tutorName = '';
  String tutorInfoId = '';
  initTutor() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutors')
        .where('id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      tutorId = documents.first.get('id');
      tutorName = documents.first.get('name');
    });
  }

  initTutorInfo() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutor_info')
        .where('tutor_id', isEqualTo: widget.tutorId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      tutorInfoId = documents.first.get('id');
    });
  }

  @override
  void initState() {
    initTutor();
    initTutorInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initTutor();
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
                  'Tutor Dashboard',
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tutorName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.tealAccent.shade700,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 50, 0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TutorProfileScreen(
                                tutorId: tutorId,
                              ),
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 50, 0)),
                        onPressed: () {
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) => TutorInfoScreen(
                                        tutorId: tutorId,
                                        loginMethod: 'login',
                                        tutorInfoId: tutorInfoId,
                                      )));
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Appointments',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 50, 0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AppointmentListScreen(),
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            fixedSize: Size(
                                MediaQuery.of(context).size.width - 50, 0)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent.shade700,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return new StreamBuilder(
  //     stream: FirebaseFirestore.instance
  //         .collection('tutor')
  //         .doc(widget.tutorId)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return new Text("Loading");
  //       }
  //       print(snapshot.data.toString());
  //       return Scaffold(
  //         body: Stack(
  //           alignment: Alignment.topLeft,
  //           children: [
  //             SingleChildScrollView(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   const Image(
  //                     image: AssetImage('assets/images/head.png'),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   const Text(
  //                     'Tutor Dashboard',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   const Image(
  //                     image: AssetImage('assets/images/tutuser.png'),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   const Text(
  //                     'Fsafasfas',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Container(
  //                     margin: const EdgeInsets.symmetric(horizontal: 15),
  //                     padding: const EdgeInsets.all(20),
  //                     decoration: BoxDecoration(
  //                       borderRadius: const BorderRadius.all(
  //                         Radius.circular(10),
  //                       ),
  //                       color: Colors.tealAccent.shade700,
  //                     ),
  //                     width: MediaQuery.of(context).size.width,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         ElevatedButton(
  //                           child: const Text(
  //                             'Profile',
  //                             style: TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           style: ElevatedButton.styleFrom(
  //                               primary: Colors.white,
  //                               onPrimary: Colors.black,
  //                               fixedSize: Size(
  //                                   MediaQuery.of(context).size.width - 50, 0)),
  //                           onPressed: () {
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) =>
  //                                         const TutorProfileScreen()));
  //                           },
  //                         ),
  //                         ElevatedButton(
  //                           child: const Text(
  //                             'Information',
  //                             style: TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           style: ElevatedButton.styleFrom(
  //                               primary: Colors.white,
  //                               onPrimary: Colors.black,
  //                               fixedSize: Size(
  //                                   MediaQuery.of(context).size.width - 50, 0)),
  //                           onPressed: () {
  //                             // Navigator.push(
  //                             //     (context),
  //                             //     MaterialPageRoute(
  //                             //         builder: (context) =>
  //                             //             const TutorInfoScreen()));
  //                           },
  //                         ),
  //                         ElevatedButton(
  //                           child: const Text(
  //                             'Appointments',
  //                             style: TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           style: ElevatedButton.styleFrom(
  //                               primary: Colors.white,
  //                               onPrimary: Colors.black,
  //                               fixedSize: Size(
  //                                   MediaQuery.of(context).size.width - 50, 0)),
  //                           onPressed: () {
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                 builder: (context) =>
  //                                     const AppointmentListScreen(),
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                         ElevatedButton(
  //                           child: const Text(
  //                             'Logout',
  //                             style: TextStyle(
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           style: ElevatedButton.styleFrom(
  //                               primary: Colors.white,
  //                               onPrimary: Colors.black,
  //                               fixedSize: Size(
  //                                   MediaQuery.of(context).size.width - 50, 0)),
  //                           onPressed: () {
  //                             Navigator.pushAndRemoveUntil(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) =>
  //                                         const LoginScreen()),
  //                                 (route) => false);
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   ElevatedButton(
  //                     child: const Text(
  //                       'Delete Account',
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     style: ElevatedButton.styleFrom(
  //                       primary: Colors.tealAccent.shade700,
  //                       onPrimary: Colors.white,
  //                     ),
  //                     onPressed: () {},
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.symmetric(
  //                 vertical: 10,
  //                 horizontal: 5,
  //               ),
  //               child: IconButton(
  //                 icon: const Icon(Icons.arrow_back),
  //                 color: Colors.white,
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}

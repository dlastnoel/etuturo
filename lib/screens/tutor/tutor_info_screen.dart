import 'package:etuturo_app/screens/tutor/tutor_dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TutorInfoScreen extends StatefulWidget {
  const TutorInfoScreen(
      {Key? key,
      required this.tutorId,
      required this.tutorInfoId,
      required this.loginMethod})
      : super(key: key);
  final String loginMethod;
  final String tutorInfoId;
  final String tutorId;

  @override
  State<TutorInfoScreen> createState() => _TutorInfoScreenState();
}

class _TutorInfoScreenState extends State<TutorInfoScreen> {
  bool _availability = false;
  final _ratePerHourController = TextEditingController();

  initTutorInfo() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('tutor_info')
        .where('id', isEqualTo: widget.tutorInfoId)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    // print(documents.length);
    setState(() {
      _availability = documents.first.get('availability');
      _ratePerHourController.text = documents.first.get('rate_per_hour');
    });
  }

  @override
  void initState() {
    if (widget.loginMethod == 'signup') {
      _ratePerHourController.text = '0';
    } else {
      initTutorInfo();
    }
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  // return Scaffold(
  //   body: Stack(
  //     alignment: Alignment.topLeft,
  //     children: [
  //       SingleChildScrollView(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             const Image(
  //               image: AssetImage('assets/images/head.png'),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             const Text(
  //               'Tutor Information',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             const Image(
  //               image: AssetImage('assets/images/tutuser.png'),
  //             ),
  //             SwitchListTile(
  //               title: const Text(
  //                 'Availability',
  //               ),
  //               value: _availability,
  //               activeColor: Colors.tealAccent.shade700,
  //               inactiveTrackColor: Colors.grey,
  //               onChanged: (bool value) {
  //                 setState(() {
  //                   _availability = value;
  //                 });
  //               },
  //             ),
  //             Container(
  //               margin:
  //                   const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
  //               child: TextField(
  //                 controller: _ratePerHourController,
  //                 keyboardType: TextInputType.number,
  //                 decoration: InputDecoration(
  //                   labelText: 'Rate per hour',
  //                   hintText: 'Rate per hour',
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             ElevatedButton(
  //               child: const Text(
  //                 'Update Info',
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               style: ElevatedButton.styleFrom(
  //                   primary: Colors.tealAccent.shade700,
  //                   onPrimary: Colors.white,
  //                   fixedSize:
  //                       Size(MediaQuery.of(context).size.width - 50, 0)),
  //               onPressed: () {},
  //             )
  //           ],
  //         ),
  //       ),
  //       Container(
  //         padding: const EdgeInsets.symmetric(
  //           vertical: 10,
  //           horizontal: 5,
  //         ),
  //         child: IconButton(
  //           icon: const Icon(Icons.arrow_back),
  //           color: Colors.white,
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       )
  //     ],
  //   ),
  // );
  // }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tutor_info')
            .doc(widget.tutorInfoId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final tutorInfo = snapshot.data;
          return Scaffold(
            body: Stack(alignment: Alignment.topLeft, children: [
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
                      'Tutor Information',
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
                    SwitchListTile(
                      title: const Text(
                        'Availability',
                      ),
                      value: _availability,
                      activeColor: Colors.tealAccent.shade700,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (bool value) {
                        setState(() {
                          _availability = value;
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: TextField(
                        controller: _ratePerHourController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Rate per hour',
                          hintText: 'Rate per hour',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Update Info',
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
                            FirebaseFirestore.instance.collection('tutor_info');
                        _tutorInfoCollection.doc(widget.tutorInfoId).update({
                          'availability': _availability,
                          'rate_per_hour': _ratePerHourController.text
                        }).then((value) {
                          Fluttertoast.showToast(
                              msg: 'Info successfully updated');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TutorDashboardScreen(
                                        tutorId: widget.tutorId,
                                      )),
                              (route) => false);
                        }).catchError((error) => print('Failed: $error'));
                      },
                    )
                  ],
                ),
              ),
              if (widget.loginMethod == 'login') ...[
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
            ]),
          );
        });
  }
}

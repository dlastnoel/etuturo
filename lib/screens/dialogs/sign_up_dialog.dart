import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etuturo_app/configs/eula.dart';
import 'package:etuturo_app/models/student.dart';
import 'package:etuturo_app/models/tutor.dart';
import 'package:etuturo_app/models/tutor_info.dart';
import 'package:etuturo_app/screens/login_screen.dart';
import 'package:etuturo_app/screens/tutor/tutor_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

Future studentSignupDialog(context, Student student) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text('Before you proceed:'),
          content: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.height) / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          eula,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                final studentDoc = await FirebaseFirestore.instance
                    .collection('students')
                    .doc(student.id);
                await studentDoc.set(student.toJson());
                Fluttertoast.showToast(
                    msg: 'Student successfully registered',
                    toastLength: Toast.LENGTH_LONG);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            )
          ],
        );
      });
    },
  );
}

Future tutorSignupDialog(context, Tutor tutor, TutorInfo tutorInfo) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text('Before you proceed:'),
          content: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.height) / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          eula,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                addTutor(tutor, tutorInfo);
                Fluttertoast.showToast(
                    msg: 'Tutor successfully registered',
                    toastLength: Toast.LENGTH_LONG);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TutorInfoScreen(
                              tutorId: tutor.id,
                              tutorInfoId: tutorInfo.id,
                              loginMethod: 'sign-up',
                            )),
                    (route) => false);
              },
            )
          ],
        );
      });
    },
  );
}

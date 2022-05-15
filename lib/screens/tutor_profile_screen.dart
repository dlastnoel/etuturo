import 'package:flutter/material.dart';

class TutorProfileScreen extends StatefulWidget {
  const TutorProfileScreen({Key? key}) : super(key: key);

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
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
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Address',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: const TextField(
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
                  onPressed: () {},
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

import 'package:flutter/material.dart';

class TutorInfoScreen extends StatefulWidget {
  const TutorInfoScreen({Key? key}) : super(key: key);

  @override
  State<TutorInfoScreen> createState() => _TutorInfoScreenState();
}

class _TutorInfoScreenState extends State<TutorInfoScreen> {
  bool _availability = false;

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
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Rate per hour',
                      hintText: 'Rate per hour',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Facebook Profile Link',
                      hintText: 'Facebook Profile Link',
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

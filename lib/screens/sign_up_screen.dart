import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                const Image(
                  image: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(
                  height: 15,
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
                      labelText: 'Username',
                      hintText: 'Username',
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
                        labelText: 'Address', hintText: 'Address'),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: const Text(
                    'Sign up as Student',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent.shade700,
                    onPrimary: Colors.white, // f
                    fixedSize: const Size(200, 0),
                  ),
                  onPressed: () {
                    print('Hello world');
                  },
                ),
                ElevatedButton(
                  child: const Text(
                    'Sign up as Tutor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent.shade700,
                    onPrimary: Colors.white, // f
                    fixedSize: const Size(200, 0),
                  ),
                  onPressed: () {
                    print('Hello world');
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

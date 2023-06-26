// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_protofac/screens/SignIn_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    // Add any additional sign-out logic here
       Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInWithEmail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'Protofac',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://example.com/profile_picture.jpg'),
                      )
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                      'John Doe',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      'johndoe@example.com',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 180),
          InkWell(
            onTap: _signOut,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blueAccent)),
              child: const Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Welcome',
          style: GoogleFonts.openSans(
            color: const Color.fromRGBO(255, 95, 0, 1),
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 5.0),
              child: Text(
                'Your information',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: const Color.fromRGBO(255, 95, 0, 1),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 5.0),
              child: const Hero(
                tag: 'LockIcon',
                child: Icon(
                  FontAwesomeIcons.lockOpen,
                  size: 100,
                  color: Color.fromRGBO(13, 129, 255, 0.9),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: ',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.email!,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 50.0, right: 50.0, top: 30.0, bottom: 30.0),
              width: 350,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(13, 129, 255, 0.9),
                      textStyle: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  child: const Text('SIGN OUT'),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

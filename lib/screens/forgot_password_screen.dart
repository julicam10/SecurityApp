// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:security_app/main.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final scaffolKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Forgot Password',
          style: GoogleFonts.openSans(
            color: const Color.fromRGBO(255, 95, 0, 1),
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color.fromRGBO(255, 95, 0, 1),
            size: 40,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Receive an email to\nreset your password',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
                child: TextFormField(
                  style: GoogleFonts.openSans(),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  cursorColor: const Color.fromRGBO(13, 129, 255, 0.9),
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    hintText: 'email@example.com',
                    labelText: 'Enter your email',
                    suffixIcon: Icon(FontAwesomeIcons.at),
                  ),
                  validator: (email) {
                    if (!email!.contains('@') || !email.contains('.')) {
                      return 'Invalid Email';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(13, 129, 255, 0.9),
                    textStyle: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                icon: const Icon(Icons.email_outlined),
                label: const Text('Reset Password'),
                onPressed: resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
    try {
      final _snackBar2 = SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 4),
        content: Text('Password Reset Email Sent'),
      );
      // ignore: deprecated_member_use
      scaffolKey.currentState?.showSnackBar(_snackBar2);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      String error = e.message!;
      final _snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        content: Text(error),
      );
      // ignore: deprecated_member_use
      scaffolKey.currentState?.showSnackBar(_snackBar);
      // navigatorKey.currentState!.pop();
    }
  }
}

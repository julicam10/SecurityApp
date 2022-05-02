import 'package:flutter/material.dart';
import 'package:security_app/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailPage extends StatefulWidget {
  VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final scaffolKey = GlobalKey<ScaffoldState>();
  bool isEmailVerify = false;
  @override
  void initState() {
    super.initState();
    isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerify) {
      sendVerificationEmail();
    }
  }

  sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      String error = e.toString();
      final _snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        content: Text(error),
      );
      // ignore: deprecated_member_use
      scaffolKey.currentState?.showSnackBar(_snackBar);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerify
      ? HomeScreen()
      : Scaffold(
          key: scaffolKey,
          appBar: AppBar(
            title: const Text('Verified Email'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
        );
}

// ignore_for_file: avoid_print, prefer_const_constructors_in_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:security_app/main.dart';
import 'package:security_app/screens/forgot_password_screen.dart';
import 'package:security_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String email = '';
String password = '';
bool selectedValue = true;

class _LoginScreenState extends State<LoginScreen> {
  final scaffolKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future singIn(context) async {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      String error = e.message!;
      final _snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        content: Text(error),
      );
      // ignore: deprecated_member_use
      scaffolKey.currentState?.showSnackBar(_snackBar);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Text(
                      'Welcome!',
                      style: GoogleFonts.openSans(
                        fontSize: 70,
                        color: const Color.fromRGBO(13, 129, 255, 0.9),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Sign in to continue',
                      style: GoogleFonts.openSans(
                        fontSize: 20.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: widthScreen * 0.15),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          child: TextFormField(
                            style: GoogleFonts.openSans(),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (val) {
                              if (!val!.contains('@') || !val.contains('.')) {
                                return 'Invalid Email';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) => email = val!,
                            decoration: const InputDecoration(
                              hintText: 'email@example.com',
                              labelText: 'Enter your email',
                              suffixIcon: Icon(FontAwesomeIcons.at),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 15.0),
                          child: TextFormField(
                            style: GoogleFonts.openSans(),
                            obscureText: selectedValue,
                            controller: passwordController,
                            validator: (passwordOne) {
                              if (passwordOne!.isEmpty) {
                                return 'Please type something';
                              }
                              return null;
                            },
                            onSaved: (passwordOne) {
                              passwordOne = passwordOne!;
                              print(passwordOne);
                            },
                            decoration: InputDecoration(
                              hintText: '*****************',
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  selectedValue
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  semanticLabel: selectedValue
                                      ? 'hide password'
                                      : 'show password',
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedValue ^= true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: widthScreen * 0.10),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 30.0),
                          width: 350,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color.fromRGBO(255, 95, 0, 1),
                                  textStyle: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              child: const Text('LOGIN'),
                              onPressed: () {
                                singIn(context);
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 50.0, right: 50.0, top: 10.0),
                          width: 350,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(13, 129, 255, 0.9),
                                  textStyle: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              child: const Text('SIGN UP'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text.rich(
                            TextSpan(
                              text: '',
                              style: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 20,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordPage())),
                                  text: 'Forgot Password ?',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromRGBO(13, 129, 255, 1),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: widthScreen * 0.050),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 30.0),
                          child: Divider(
                            color: Colors.black45,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Social Media Singup',
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              color: Colors.black26,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.google,
                                  color: Color.fromRGBO(244, 180, 0, 1),
                                  size: 35.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.phone,
                                  color: Color.fromRGBO(15, 157, 88, 1),
                                  size: 40.0,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                FontAwesomeIcons.facebook,
                                color: Color.fromRGBO(59, 89, 152, 1),
                                size: 35.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

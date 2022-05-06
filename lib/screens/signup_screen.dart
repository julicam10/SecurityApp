// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:security_app/main.dart';
import 'package:security_app/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

String name = '';
String email = '';
String passwordOne = '';
String passwordTwo = '';
String selectedValue = 'None';
bool passwordVisibleTwo = true;
bool selectedValueOne = true;

class _SignUpScreen extends State<SignUpScreen> {
  final scaffolKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordOneController = TextEditingController();
  final passwordTwoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
  }

  Future singIn() async {
    _submit();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordTwoController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
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
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Text(
                  'Hello,',
                  style: GoogleFonts.openSans(
                    color: const Color.fromRGBO(255, 95, 0, 1),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, left: 20.0),
                child: Text(
                  'Create a new account with us',
                  style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: heightScreen / 1.7,
                    width: widthScreen * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: NameTextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: EmailTextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: PasswordTextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: ConfirmPasswordTextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: RolWidgets(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 350,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(255, 95, 0, 1),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        child: Text('SIGN UP', style: GoogleFonts.openSans()),
                        onPressed: () {
                          setState(() {
                            singIn();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen())),
                          text: 'Sign in',
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(13, 129, 255, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField NameTextFormField() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      style: GoogleFonts.openSans(),
      textCapitalization: TextCapitalization.words,
      validator: (name) {
        if (name!.isEmpty) {
          return 'Please type your name';
        }
      },
      onSaved: (val) => name = val!,
      decoration: const InputDecoration(
        hintText: 'Juan Carlos Gomez',
        labelText: 'Enter your name',
      ),
    );
  }

  TextFormField EmailTextFormField() {
    return TextFormField(
      controller: emailController,
      style: GoogleFonts.openSans(),
      keyboardType: TextInputType.emailAddress,
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
      ),
    );
  }

  TextFormField PasswordTextFormField() {
    return TextFormField(
      obscureText: selectedValueOne,
      controller: passwordOneController,
      style: GoogleFonts.openSans(),
      validator: (passwordOne) {
        if (passwordOne!.isEmpty) {
          return 'Please type something';
        }
        if (passwordOne.length < 8) {
          return 'Your password needs more characters';
        }
        if (!passwordOne.contains(RegExp(r"[a-z]"))) {
          return 'Your password needs a lowercase letter';
        }
        if (!passwordOne.contains(RegExp(r"[A-Z]"))) {
          return 'Your password needs an upcase letter';
        }
        if (!passwordOne.contains(RegExp(r"[0-9]"))) {
          return 'Your password needs a number';
        }
        if (!passwordOne.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          return 'Your password needs a special character';
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
            selectedValueOne ? Icons.visibility : Icons.visibility_off,
            semanticLabel: selectedValueOne ? 'hide password' : 'show password',
          ),
          onPressed: () {
            setState(() {
              selectedValueOne ^= true;
            });
          },
        ),
      ),
    );
  }

  TextFormField ConfirmPasswordTextFormField() {
    return TextFormField(
      obscureText: passwordVisibleTwo,
      controller: passwordTwoController,
      style: GoogleFonts.openSans(),
      validator: (passwordTwo) {
        if (passwordTwo!.isEmpty) {
          return 'Please type something';
        }
        if (passwordTwoController.text != passwordOneController.text) {
          return 'Password are not the same';
        } else {
          return null;
        }
      },
      onSaved: (passwordTwo) {
        passwordTwo = passwordTwo!;
        print(passwordTwo);
      },
      decoration: InputDecoration(
        hintText: '*****************',
        labelText: 'Confirm password',
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisibleTwo ? Icons.visibility : Icons.visibility_off,
            semanticLabel:
                passwordVisibleTwo ? 'hide password' : 'show password',
          ),
          onPressed: () {
            setState(() {
              passwordVisibleTwo ^= true;
            });
          },
        ),
      ),
    );
  }

  Row RolWidgets() {
    return Row(
      children: [
        Text(
          'What is your rol?',
          style: GoogleFonts.openSans(
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: DropdownButton(
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            value: selectedValue,
            items: [
              DropdownMenuItem(
                  child: Text("None", style: GoogleFonts.openSans()),
                  value: "None",
                  enabled: false),
              DropdownMenuItem(
                  child: Text("Admin", style: GoogleFonts.openSans()),
                  value: "Admin"),
              DropdownMenuItem(
                  child: Text("Seller", style: GoogleFonts.openSans()),
                  value: "Seller"),
            ],
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
                print(selectedValue);
              });
            },
          ),
        ),
      ],
    );
  }
}

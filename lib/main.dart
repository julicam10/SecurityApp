import 'package:flutter/material.dart';
import 'package:security_app/screens/signup2_screen.dart';
import 'package:security_app/screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: SignUp2Screen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:security_app/screens/signup_screen.dart';

class EmailTextformField extends StatelessWidget {
  const EmailTextformField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
}

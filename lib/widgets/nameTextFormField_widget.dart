import 'package:flutter/material.dart';
import 'package:security_app/screens/signup_screen.dart';

class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
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
}

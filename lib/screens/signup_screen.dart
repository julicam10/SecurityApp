import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  String password = '';
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    children: [
                      EmailTextField(emailController: emailController),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 350,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      autofocus: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: emailController.text.isEmpty ? Colors.red : Colors.green,
        hintText: 'email@example.com',
        labelText: 'Enter your email',
        counter: Text('Long: ${emailController.text.length}'),

        icon: const Icon(Icons.mail_outline_rounded),
        suffixIcon: emailController.text.isEmpty
            ? const Icon(
                Icons.sms_failed_rounded,
                color: Colors.red,
              )
            : const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
      ),
    );
  }
}
//   buildEmail() => const TextField(
//       );
// }
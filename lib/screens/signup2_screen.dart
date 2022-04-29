import 'package:flutter/material.dart';

class SignUp2Screen extends StatefulWidget {
  const SignUp2Screen({Key? key}) : super(key: key);

  @override
  State<SignUp2Screen> createState() => _SignUp2ScreenState();
}

class _SignUp2ScreenState extends State<SignUp2Screen> {
  // final emailController = TextEditingController();
  final scaffolKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    // emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      // perfomLogin();
    }
  }

  // void perfomLogin(){
  //   final snackbar = new SnackBar(
  //     content: new Text('Email: $_email and Password $_password'),
  //   );
  //   scaffolKey.currentState.showSnackBar(snackbar);
  // }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffolKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: heightScreen / 2,
              width: widthScreen * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
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
                      TextFormField(
                        validator: (val) {
                          if (!val!.contains('@') || !val.contains('.')) {
                            return 'Invalid Email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) => _email = val!,
                        decoration: const InputDecoration(
                          hintText: 'email@example.com',
                          labelText: 'Enter your email',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: TextFormField(
                          // validator: (val) =>
                          //     val!.length < 6 ? 'Invalid Password' : null,
                          validator: (val) {
                            if (val!.length < 6 || !val.contains('.')) {
                              return 'Invalid Password';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => _password = val!,
                          decoration: const InputDecoration(
                            hintText: '*****************',
                            labelText: 'Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: _submit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

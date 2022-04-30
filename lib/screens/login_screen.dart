import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String email = '';
String password = '';
bool selectedValue = true;

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 20.0),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 70,
                    color: Color.fromRGBO(61, 178, 255, 1),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5.0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Sign in to continue',
                  style: TextStyle(fontSize: 20.0, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/img/security.png',
                      fit: BoxFit.contain),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 30.0),
                    child: TextFormField(
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
                          suffixIcon: Icon(FontAwesomeIcons.at)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 20.0),
                    child: TextFormField(
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
                  Container(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 30.0),
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
                        child: const Text('SIGN UP'),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                    child: Divider(
                      color: Colors.black45,
                      height: 1,
                      thickness: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Social Media Singup',
                      style: TextStyle(
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
                            color: Color.fromRGBO(219, 68, 55, 1),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

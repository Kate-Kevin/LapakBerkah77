import 'package:flutter/material.dart';
import 'package:lapakberkah77/services/auth.dart';
import 'package:lapakberkah77/shared/constants.dart';
import 'package:lapakberkah77/shared/loading.dart';
import 'package:lapakberkah77/shared/theme.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  // ignore: use_key_in_widget_constructors
  const SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: theme().scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme().primaryColor,
              elevation: 0.0,
              title: const Text('Sign in'),
              /* actions: [
          TextButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            style: TextButton.styleFrom(primary: Colors.white),
            icon: Icon(Icons.person), 
            label: Text('Register')
            )
        ], */
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                              width: 400,
                              height: 200,
                              child: Image.asset(
                                'assets/logo.png',
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) {
                              return val!.isEmpty ? 'Enter an Email' : null;
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) {
                              return val!.length < 6
                                  ? 'Enter a Password 6+ chars long'
                                  : null;
                            },
                            obscureText: true,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: theme().primaryColor),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await _auth.signInrWithEmailandPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = 'Failed Sign In';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: theme().primaryColor),
                              onPressed: () {
                                Navigator.pushNamed(context, '/lupapassword');
                              },
                              child: const Text('Lupa Password?')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Belum ada akun? '),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: theme().primaryColor),
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                  child: const Text('Register')),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14.0),
                          ),
                        ],
                      ))),
            ),
          );
  }
}

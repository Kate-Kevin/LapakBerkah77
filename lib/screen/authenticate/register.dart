import 'package:flutter/material.dart';
import 'package:lapakberkah77/services/auth.dart';
import 'package:lapakberkah77/shared/constants.dart';
import 'package:lapakberkah77/shared/loading.dart';
import 'package:lapakberkah77/shared/theme.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  // ignore: use_key_in_widget_constructors
  const Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: theme().scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme().primaryColor,
              elevation: 0.0,
              title: const Text('Register'),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    icon: const Icon(Icons.person),
                    label: const Text('Sign In'))
              ],
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
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Username'),
                            validator: (val) {
                              return val!.isEmpty ? 'Masukan Username' : null;
                            },
                            onChanged: (val) {
                              setState(() {
                                username = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) {
                              return val!.isEmpty ? 'Masukan Email' : null;
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
                                  ? 'Password Harus Memiliki Panjang Lebih Dari 6'
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: theme().primaryColor),
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) => const Center(
                                          child: CircularProgressIndicator(),
                                        ));
                                dynamic result =
                                    _auth.registerWithEmailandPassword(
                                        email, password, username);
                                Navigator.of(context).popUntil((route) => false);
                                if (result == null) {
                                  setState(() {
                                    error = 'error';
                                    loading = false;
                                  });
                                }
                              }
                            },
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

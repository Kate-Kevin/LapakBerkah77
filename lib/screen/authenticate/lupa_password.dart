import 'package:flutter/material.dart';
import 'package:lapakberkah77/services/auth.dart';
import 'package:lapakberkah77/shared/constants.dart';
import 'package:lapakberkah77/shared/theme.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  static const String routeName = '/lupapassword';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LupaPassword(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  bool showSignIn = true;
  toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late BuildContext _scaffoldContext;

  String email = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme().primaryColor,
        title: const Text('Lupa Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Builder(builder: (BuildContext context) {
          _scaffoldContext = context;
          return Form(
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
                  const Text('Check email untuk menganti password'),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
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
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _auth.resetPassword(email);
                        ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
                          SnackBar(
                            backgroundColor: theme().primaryColorDark,
                            content: const Text('Password reset successful'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.email_outlined),
                    label: const Text('Reset Password'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme().primaryColor),
                  )
                ],
              ));
        }),
      ),
    );
  }
}

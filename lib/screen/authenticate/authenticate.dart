import 'package:flutter/material.dart';
import 'package:lapakberkah77/screen/authenticate/register.dart';
import 'package:lapakberkah77/screen/authenticate/sign_in.dart';

// ignore: use_key_in_widget_constructors
class Authenticate extends StatefulWidget {

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
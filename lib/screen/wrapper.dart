import 'package:flutter/material.dart';
import 'package:lapakberkah77/screen/authenticate/authenticate.dart';
import 'package:lapakberkah77/screen/home/home.dart';
import 'package:lapakberkah77/services/auth.dart';


// ignore: use_key_in_widget_constructors
class Wrapper extends StatefulWidget {

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Authservice().authStateChanges,
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return Home();
        }else{
          return Authenticate();
        }
      },
      );
    
  }
}
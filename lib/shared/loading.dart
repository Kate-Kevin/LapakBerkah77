import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lapakberkah77/shared/theme.dart';

// ignore: use_key_in_widget_constructors
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme().scaffoldBackgroundColor,
      child: Center(
        child: SpinKitCircle(
          color: theme().primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
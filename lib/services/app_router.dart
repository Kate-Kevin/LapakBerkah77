// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:lapakberkah77/screen/authenticate/lupa_password.dart';
import 'package:lapakberkah77/screen/home/home.dart';
import 'package:lapakberkah77/screen/home/jual_rongsokan/list_barang.dart';
import 'package:lapakberkah77/screen/home/jual_rongsokan/map.dart';
import 'package:lapakberkah77/screen/home/jual_rongsokan/pilihan.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings){
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return Home.route();
      case Pilihan.routeName:
        return Pilihan.route();
      case ListBarang.routeName:
        return ListBarang.route();
      case Location.routeName:
        return Location.route();
      case LupaPassword.routeName:
        return LupaPassword.route();
      default:
        return _errorroute();
    }
  }

  static Route _errorroute(){
    return MaterialPageRoute(
      builder:(_) => Scaffold(appBar: AppBar(title: const Text('Error'),),),
      settings: const RouteSettings(name: '/error'),
      );
  }
}

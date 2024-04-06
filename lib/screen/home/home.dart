import 'package:flutter/material.dart';
import 'package:lapakberkah77/screen/nav/cek_harga.dart';
import 'package:lapakberkah77/screen/nav/home_nav.dart';
import 'package:lapakberkah77/screen/nav/pesanan_aktif.dart';
import 'package:lapakberkah77/screen/nav/profile.dart';
import 'package:lapakberkah77/shared/theme.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  static const String routeName = '/';

  static Route route(){
    return MaterialPageRoute(
      builder:(_) => Home(),
      settings: const RouteSettings(name: routeName),
      );
  }

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  List page =  [
    HomeBody(),
    CekHarga(),
    PesananAktif(),
    Profile(),
  ];
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      backgroundColor: theme().primaryColorLight,
      body: Container(
        padding: MediaQuery.of(context).padding,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: page[_selectedIndex],
      ),

      bottomNavigationBar: botnav(),
    );
  }

  BottomNavigationBar botnav() {
    return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: theme().primaryColorDark,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: theme().primaryColor,),
    selectedItemColor: theme().primaryColor,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    unselectedIconTheme: IconThemeData(color: theme().primaryColorLight),
    unselectedItemColor: theme().primaryColorLight,

    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.price_check),
        label: 'Cek Harga',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.task),
        label: 'Pesanan Aktif',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    currentIndex: _selectedIndex,
    onTap:(index){
      setState(() {
        _selectedIndex = index;
      });
    },
    );
  }
}
 
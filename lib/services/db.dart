import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DB {
  Future<void> tambahPesanan(Map pesanan, DateTime waktu, double totalharga) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final currentUser = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot docSnapshot =
          await firestore.collection('Users').doc(currentUser.email).get();
      String alamat = docSnapshot['address'];
      Map<String, dynamic> data = {
        'waktu': waktu,
        'status': false,
        'alamat': alamat,
        'barang': pesanan,
        'totalHarga': totalharga,
        'user': currentUser.email,
      };

      await firestore.collection('Pesanan').doc().set(data);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
  Widget checkIcon(bool status){

    Widget icon;

    if (status == true) {
      icon = const Icon(Icons.check_circle,);
      return Column(children: [icon,const Text('Selesai')],);
    }
    if (status == false) {
      icon = const Icon(Icons.pending,);
      return Column(children: [icon , const Text('Sedang di Proses')],);
    }else{return const Text('Something went wrong');}
    
  }
}

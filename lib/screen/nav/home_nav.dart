import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapakberkah77/shared/theme.dart';

// ignore: use_key_in_widget_constructors
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Column(
      children: [
        SizedBox(
            width: 400,
            height: 100,
            child: Image.asset(
              'assets/logo_home.png',
              fit: BoxFit.cover,
            )),
        Container(
          height: 100,
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Align(
              alignment: Alignment.centerLeft,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Selamat datang, ${userData['username']}.'),
                            const SizedBox(height: 5,),
                            const Text(
                                'Lapak Berkah 77 adalah aplikasi untuk menjual rongsokkan dengan harga yang kompetitif dan gratis penjemputan untuk daerah Jakarta.')
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error ${snapshot.error}'),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: theme().primaryColor),
            onPressed: () {
              Navigator.pushNamed(context, '/pilihan');
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart),
                Padding(padding: EdgeInsets.only(left: 5)),
                Text(
                  'Jual Rongsokan',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

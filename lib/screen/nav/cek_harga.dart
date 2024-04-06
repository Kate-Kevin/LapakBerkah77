import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapakberkah77/shared/loading.dart';

// ignore: use_key_in_widget_constructors
class CekHarga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collection =
        FirebaseFirestore.instance.collection('Barang').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: collection,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Terjadi kesalahan: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data!.docs;

            return SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? data =
                          documents[index].data() as Map<String, dynamic>?;
                      String foto = data?['foto'];
                      int hargaInt = data?['harga'];
                      double harga = hargaInt.toDouble(); 


                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  'assets/$foto',
                                )),
                            Column(
                              children: [
                                Text(data?['nama']),
                                Text(
                                    'Harga : Rp.$harga / kg')
                              ],
                            ),
                          ],
                        ),
                      );
                    }));
          }
          return const Text('Something Went Wrong');
        });
  }
}

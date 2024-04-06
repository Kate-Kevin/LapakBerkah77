import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lapakberkah77/shared/loading.dart';
import 'package:lapakberkah77/shared/theme.dart';

class DetailPesanan extends StatefulWidget {
  final String documentId;
  const DetailPesanan({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  /* static const String routeName = '/detailbarang';

  Route route() {
    return MaterialPageRoute(
      builder: (_) => DetailPesanan(documentId: documentId,),
      settings: const RouteSettings(name: routeName),
    );
  } */

  @override
  State<DetailPesanan> createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Pesanan')
            .doc(widget.documentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('Data not found');
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final Map<String, dynamic> daftarBarang = data['barang'];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme().primaryColor,
              title: const Text('Detail Pesanan'),
            ),
            body: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Barang'), Text('Jumlah'), Text('Harga')],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: daftarBarang.length,
                    itemBuilder: (context, index) {
                      final List<String> keys = daftarBarang.keys.toList();
                      final String nama = keys[index];
                      final Map<String, dynamic> barang = daftarBarang[nama];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(nama),
                                Text(barang['jumlah'].toString()),
                                Text('Rp.${barang['harga'].toString()}')
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                Text('Total Harga: ${data['totalHarga'].toString()}')
              ],
            ),
          );
        });
  }
}

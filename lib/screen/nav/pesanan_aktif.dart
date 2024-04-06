import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapakberkah77/screen/home/detail_pesanan.dart';
import 'package:lapakberkah77/services/db.dart';
import 'package:lapakberkah77/shared/loading.dart';

// ignore: use_key_in_widget_constructors
class PesananAktif extends StatefulWidget {
  @override
  State<PesananAktif> createState() => _PesananAktifState();
}

class _PesananAktifState extends State<PesananAktif> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Pesanan')
            .where('user', isEqualTo: currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Tidak ada pesanan.'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = snapshot.data!.docs[index];
                final Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                Timestamp timestamp = data['waktu'];
                DateTime waktu = timestamp.toDate();
                String id = document.id;
                return Card(
                  child: Column(
                    children: [
                      Text(waktu.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DB().checkIcon(data['status']),
                          Text('Kode : ${document.id}'),
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Pesanan')
                                    .doc(id)
                                    .get()
                                    .then((doc) {
                                  bool documentExists = doc.exists;
                                  if (documentExists) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPesanan(
                                          documentId: id,
                                        ),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          title: const Text('Data Not Found'),
                                          content: const Text(
                                              'The requested data does not exist.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(dialogContext);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                              icon: const Icon(Icons.arrow_circle_right))
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}

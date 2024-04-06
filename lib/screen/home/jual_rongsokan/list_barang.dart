import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapakberkah77/blocs/basket/basket_bloc.dart';
import 'package:lapakberkah77/model/barang.dart';
import 'package:lapakberkah77/screen/home/home.dart';
import 'package:lapakberkah77/services/db.dart';
import 'package:lapakberkah77/shared/theme.dart';

class ListBarang extends StatefulWidget {
  const ListBarang({super.key});

  static const String routeName = '/listbarang';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ListBarang(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<ListBarang> createState() => _ListBarangState();
}

class _ListBarangState extends State<ListBarang> {
  double hitungTotalHargaKeranjang(List<Barang> items) {
    double totalHarga = 0;
    for (var item in items) {
      totalHarga += item.harga * item.banyak;
    }
    return totalHarga;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme().primaryColor,
        title: const Text('Barang Pilihan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            if (state is BasketLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BasketLoaded) {
              return state.basket.items.isEmpty
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('No Item in the Basket')],
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.basket.items.length,
                          itemBuilder: (context, index) {
                            final item = state.basket.items[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(item.nama),
                                      Column(
                                        children: [
                                          Text('Harga/Kg: ${item.harga}'),
                                          Row(
                                            children: [
                                              const Text('Masukan Berat: '),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (item.banyak > 0) {
                                                        item.banyak--;
                                                      }
                                                    });
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                              Text('${item.banyak} Kg'),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      item.banyak++;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add)),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
            } else {
              return const Text('Something Went Wrong');
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          if (state is BasketLoading) {
            return const CircularProgressIndicator();
          }
          if (state is BasketLoaded) {
            final totalHargaKeranjang =
                hitungTotalHargaKeranjang(state.basket.items);
            return BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total: ${totalHargaKeranjang.toStringAsFixed(2)}'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: theme().primaryColor),
                      onPressed: () {
                        Map<String, dynamic> pesananData = {};
                        for (var item in state.basket.items) {
                          pesananData[item.nama] = {
                            'jumlah': item.banyak,
                            'harga': item.harga,
                          };
                        }
                        DateTime waktu = DateTime.now();
                        DB().tambahPesanan(pesananData, waktu,totalHargaKeranjang);
              
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Permintaan Terkirim'),
                                content: const Text(
                                    'Pesanan Anda telah berhasil dikirim.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      // Kembali ke menu utama (home)
                                      Navigator.pushAndRemoveUntil(context, Home.route() , (route) => false);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Text('Minta Penjemputan'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Something Went Wrong');
          }
        },
      ),
    );
  }
}

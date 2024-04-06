import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapakberkah77/blocs/basket/basket_bloc.dart';
import 'package:lapakberkah77/model/barang.dart';
import 'package:lapakberkah77/shared/loading.dart';
import 'package:lapakberkah77/shared/theme.dart';

class Pilihan extends StatefulWidget {
  const Pilihan({super.key});

  static const String routeName = '/pilihan';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const Pilihan(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<Pilihan> createState() => _PilihanState();
}

class _PilihanState extends State<Pilihan> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    /* Barang barang = Barang.barang[0]; */

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme().primaryColor,
        title: const Text('Jual Rongsokan'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text('Pilih Tipe Barang Apa Saja Yang di Jual:'),
              ),
              const SizedBox(
                height: 50,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Barang')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Loading();
                    }

                    final documents = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final Map data = documents[index].data() as Map;
                        Barang barang = Barang(
                            nama: data['nama'],
                            banyak: 1,
                            harga: data['harga']);
                        return CheckBoxes(
                          barang: barang,
                        );
                      },
                    );
                  }),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: theme().primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, '/listbarang');
                  },
                  child: const Text('Pilih')),
            ],
          ),
        ),
      ),
    );
  }
}
/* Widget CheckBoxTile(bool? isChecked,Barang barang,BuildContext context,int index) {
  
    return  CheckboxListTile(
            title: Text(barang.nama),
            value: isChecked,
            onChanged: (_) {
              isChecked = !isChecked!;
            },
    );
 } */

class CheckBoxes extends StatefulWidget {
  final Barang barang;

  const CheckBoxes({
    super.key,
    required this.barang,
  });

  @override
  State<CheckBoxes> createState() => _CheckBoxesState();
}

class _CheckBoxesState extends State<CheckBoxes> {
  bool valStart = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BasketLoaded) {
          return CheckboxListTile(
              activeColor: theme().primaryColor,
              title: Text(widget.barang.nama),
              value: valStart,
              onChanged: (val) {
                setState(() {
                  valStart = val!;
                  if (valStart == true) {
                    context.read<BasketBloc>().add(AddItem(widget.barang));
                  } else if (valStart == false) {
                    context.read<BasketBloc>().add(RemoveItem(widget.barang));
                  }
                });
              });
        } else {
          return const Text('something went wrong');
        }
      },
    );
  }
}

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Barang extends Equatable {

  final String nama;
  final int harga;
  int banyak;

  Barang({required this.nama, this.harga = 0, this.banyak= 0});
  
  @override

  List<Object?> get props => [nama,harga,banyak];

  /* final int id;
  final String nama;
  final double harga;
  bool? val;
  double? banyak;
  final String foto;
 */


  /* Barang(
      {required this.id,
      required this.nama,
      required this.harga,
      this.val,
      this.banyak = 1,
      required this.foto});

  @override
  List<Object?> get props => [id, nama, harga, val,banyak, foto]; */

 /*  static List<Barang> barang = [
    Barang(
        id: 1,
        nama: 'Gelas Plastik',
        harga: 1000,
        val: false,
        foto: 'assets/gelas_plastik.jpg'),
    Barang(
        id: 2,
        nama: 'Besi Tua',
        harga: 2000,
        val: false,
        foto: 'assets/besi.jpg'),
    Barang(
        id: 3,
        nama: 'Kardus',
        harga: 3000,
        val: false,
        foto: 'assets/kardus.jpg'),
    Barang(
        id: 4,
        nama: 'Kertas',
        harga: 4000,
        val: false,
        foto: 'assets/kertas.jpg'),
  ]; */

}

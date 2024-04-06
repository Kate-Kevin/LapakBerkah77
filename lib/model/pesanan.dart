import 'package:equatable/equatable.dart';

class Pesanan extends Equatable {
  final String uid;
  final DateTime date;
  final bool status;
  final String estimasiWaktu;
  final double estimasiHarga;

  const Pesanan(
      {required this.uid,
      required this.date,
      this.status = false,
      required this.estimasiWaktu,
      required this.estimasiHarga});

  @override
  
  List<Object?> get props => [uid, date, status, estimasiWaktu, estimasiHarga];

  /* static List<Pesanan> pesanan =[
    Pesanan(uid: '1', date: date, estimasiWaktu: estimasiWaktu, estimasiHarga: estimasiHarga)
  ]; */
}

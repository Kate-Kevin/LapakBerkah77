import 'package:equatable/equatable.dart';
import 'package:lapakberkah77/model/barang.dart';

class Basket extends Equatable{
  final List<Barang> items;
    const Basket({
    this.items = const <Barang>[]
  });

  Basket copyWith({
    List<Barang>? items,
  }){
    return Basket(
      items: items ?? this.items,
    );
  }
  
  @override
  List<Object?> get props => [items];

  double get subtotal => 
    items.fold(0, (total, current) => total + current.harga);

  Map itemQuantity(items){
    var quantity = {};

    items.forEach((item){
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    return quantity;
  }

  String get subtotalString => subtotal.toStringAsFixed(3);
}
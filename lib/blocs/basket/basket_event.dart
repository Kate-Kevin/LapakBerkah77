part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object> get props => [];
}

class StartBasket extends BasketEvent{

  @override
  List<Object> get props => [];
}
class AddItem extends BasketEvent{
  final Barang item;

  const AddItem(this.item);

  @override
  List<Object> get props => [item];
}
class RemoveItem extends BasketEvent{
  
  final Barang item;

  const RemoveItem(this.item);

  @override
  List<Object> get props => [item];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lapakberkah77/model/barang.dart';
import 'package:lapakberkah77/model/basket_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);

  }

  void _onStartBasket(StartBasket event, Emitter<BasketState> emit)async{
    emit(BasketLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const BasketLoaded(basket: Basket()));
    } catch (_) {}

  }

  void _onAddItem(AddItem event, Emitter<BasketState> emit){
    final state =this.state;
    if (state is BasketLoaded) {
      try {
        emit(BasketLoaded(
          basket: state.basket.copyWith(
            items: List.from(state.basket.items)..add(event.item)
          )));
      } catch (_) {}
    }
  }

  void _onRemoveItem(RemoveItem event, Emitter<BasketState> emit){
    final state =this.state;
    if (state is BasketLoaded) {
      try {
        emit(BasketLoaded(
          basket: state.basket.copyWith(
            items: List.from(state.basket.items)..remove(event.item)
          )));
      } catch (_) {}
    }
  }
}

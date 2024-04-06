import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lapakberkah77/model/place_autocomplete_model.dart';
import 'package:lapakberkah77/repositories/places/places_repositories.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlaceRepository _placeRepository;
  StreamSubscription? _placeSubscription;

  AutocompleteBloc({required PlaceRepository placeRepository}) : 
  _placeRepository = placeRepository,
  super(AutocompleteLoading()){
    on<LoadAutoComplete>(_onLoadAutoComplete);
  }

  void _onLoadAutoComplete(LoadAutoComplete event,Emitter<AutocompleteState> emit)async{
    _placeSubscription?.cancel();

    final List<PlaceAutocomplete> autocomplete = 
      await _placeRepository.getAutocomplete(event.searchInput);
    
    emit(AutocompleteLoaded(autocomplete: autocomplete));
  }

}

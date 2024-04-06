import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lapakberkah77/model/place_model.dart';
import 'package:lapakberkah77/repositories/places/places_repositories.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  PlaceBloc({required PlaceRepository placesRepository}) :
    _placesRepository = placesRepository,
   super(PlaceLoading()){
    on<LoadPlace>(_onLoadPlace);
   }

   void _onLoadPlace(LoadPlace event,Emitter<PlaceState> emit)async{
    emit(PlaceLoading());
    try{
      _placesSubscription?.cancel();
      final Place place = await _placesRepository.getPlace(event.placeId);
      emit(PlaceLoaded(place: place));
    }catch (_){}
   }

  @override
  Future<void> close(){
    _placesSubscription?.cancel();
    return super.close();
  }
  }


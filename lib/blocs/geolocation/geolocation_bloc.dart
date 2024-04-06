import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:equatable/equatable.dart';
import 'package:lapakberkah77/repositories/geolocation/geolocation_repositories.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent,GeolocationState>{
  final GeolocationRepositories _geolocationRepositories;
  StreamSubscription? _geolocationSubscription;

  GeolocationBloc({required GeolocationRepositories geolocationRepositories}): 
  _geolocationRepositories = geolocationRepositories,
  super(GeolocationLoading()){
    on<LoadGeolocation>(_onLoadGeolocation);
    on<UpdateGeolocation>(_onUpdateGeolocation);
  }

  void _onLoadGeolocation(LoadGeolocation event,Emitter<GeolocationState> emit)async{
    _geolocationSubscription?.cancel();
    final Position position = await _geolocationRepositories.getCurrentLocation();

    add(UpdateGeolocation(position: position));
  }

  void _onUpdateGeolocation(UpdateGeolocation event,Emitter<GeolocationState> emit){
    emit(GeolocationLoaded(position: event.position));
  }

  @override
  Future<void>close(){
    _geolocationSubscription?.cancel();
    return super.close();
  }

}
// ignore_for_file: body_might_complete_normally_nullable

import 'package:lapakberkah77/model/place_autocomplete_model.dart';
import 'package:lapakberkah77/model/place_model.dart';

abstract class BasePlaceRepository{
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput) async{}
  Future<Place?> getPlace(String placeId) async{}
}
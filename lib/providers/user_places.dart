import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier(super.state); //UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation placeLocation) {
    final newPlace = Place(title: title, image: image, location: placeLocation);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier([]));

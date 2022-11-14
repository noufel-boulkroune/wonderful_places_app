import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wonderful_places_app/helpers/db_helper.dart';
import '../models/place.dart';

class WonderfulPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  addPlace({required String pickedTitle, required File pickedImage}) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: PlaceLocation(latitude: 0, longtude: 0),
        image: pickedImage);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map((places) => Place(
            id: places["id"],
            title: places["title"],
            location: PlaceLocation(latitude: 0, longtude: 0),
            image: File(places["image"])))
        .toList();
    notifyListeners();
  }
}

import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screens/place_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet.',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          places[index].title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        onTap: () {
          if (Platform.isIOS) {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => PlaceDetails(place: places[index]),
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlaceDetails(place: places[index]),
            ));
          }
        },
      ),
    );
  }
}

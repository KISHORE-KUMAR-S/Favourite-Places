import 'dart:io';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/add_new_place.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    void addItem() {
      if (Platform.isIOS) {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => const AddNewPlace(),
        ));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddNewPlace(),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
        child: PlacesList(places: userPlaces),
      ),
    );
  }
}

import 'dart:io';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/add_new_place.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : PlacesList(places: userPlaces),
        ),
      ),
    );
  }
}

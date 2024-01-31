import 'dart:io';

import 'package:favourite_places/screens/add_new_place.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addItem() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const PlacesList(places: []),
    );
  }
}

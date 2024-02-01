import 'dart:convert';
import 'dart:io';

import 'package:favourite_places/screens/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'package:favourite_places/models/api.dart';
import 'package:favourite_places/models/place.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  PlaceLocation? _pickedLocation;

  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) return '';

    final latitude = _pickedLocation!.latitude;
    final longitude = _pickedLocation!.longitude;
    //Google Maps Static API
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:Location%7C$latitude,$longitude&key=$apiKey';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    //Geocoding API calls
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');

    final response = await http.get(url);

    final data = json.decode(response.body);
    final address =
        data['results'][0]['formatted_address']; //View Documentation

    // if (locationData.latitude == null || locationData.longitude == null) return;

    setState(() {
      _pickedLocation = PlaceLocation(
          latitude: latitude, longitude: longitude, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  void getCurrentLocation() async {
    _isGettingLocation = true;

    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lon = locationData.longitude;

    if (lat == null || lon == null) return;

    _savePlace(lat, lon);
  }

  void _selectOnMap() async {
    final LatLng? pickedLocation;

    if (Platform.isIOS) {
      pickedLocation = await Navigator.of(context).push<LatLng>(
          CupertinoPageRoute(builder: (context) => const MapScreen()));
    } else {
      pickedLocation = await Navigator.of(context).push<LatLng>(
          MaterialPageRoute(builder: (context) => const MapScreen()));
    }

    if (pickedLocation == null) return;

    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_pickedLocation != null) {
      previewContent = ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          locationImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator.adaptive();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: previewContent,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Open Map'),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

// For Using Environment Variables
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Using json
import 'dart:convert';

// For using PlaceLocation
import 'package:favourite_places_app/models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;

  String get locationImage{
    if (_pickedLocation == null){
      print("No _pickedLocation Found");
      return '';
    }
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$lat,$lng&key=$apiKey';
  }

  // To Show Spinner When Getting Location
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
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

    // Getting the Location
    locationData = await location.getLocation();

    //Converting Location to Human-Readable Address
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      print("Lat or Long is Null");
      return;
    }

    // Getting API Key From Environment Variables
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey',
    );

    final response = await http.get(url);
    final resData = json.decode(response.body);

    final address = resData['results'][0]['formatted_address'];
    print(address);

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
        address: address,
      );
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No Location Choosen!",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );

    if (_pickedLocation != null) {
      print("Generating Image");
      previewContent = Image.network(locationImage, fit: BoxFit.cover, width: double.infinity, height: double.infinity,);
    }

    if (_isGettingLocation == true) {
      previewContent = const CircularProgressIndicator();
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
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

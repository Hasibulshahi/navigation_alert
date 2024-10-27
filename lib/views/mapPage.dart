import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'dart:developer';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LocationData? _currentLocation;
  final Location _locationService = Location();
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // Request location permissions
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // serviceEnabled = await _locationService.serviceEnabled();
    // if (!serviceEnabled) {
    //   serviceEnabled = await _locationService.requestService();
    //   if (!serviceEnabled) {
    //     return; // Handle service not enabled
    //   }
    // }

    // permissionGranted = await _locationService.hasPermission();
    // if (permissionGranted == PermissionStatus.denied) {
    //   permissionGranted = await _locationService.requestPermission();
    //   if (permissionGranted != PermissionStatus.granted) {
    //     return; // Handle permission denied
    //   }
    // }

    // Get the current location
    _currentLocation = await _locationService.getLocation();
    // Center the map on the current location
    _mapController.move(
      LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
      15.0, // Zoom level
    );

    print('Loc: ');
    print(_currentLocation);

    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Map Example'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.app',
          ),
          if (_currentLocation != null) // Only display if location is available
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
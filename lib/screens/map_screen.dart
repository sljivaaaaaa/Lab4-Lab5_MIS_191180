import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double lat; // Latitude of exam location
  final double lng; // Longitude of exam location

  MapScreen({required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng), // Set the exam location's coordinates
          zoom: 12,
        ),
      ),
    );
  }
}

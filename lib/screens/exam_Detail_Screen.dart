// exam_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3/screens/map_screen.dart';

class ExamDetailScreen extends StatelessWidget {
  final String subject;
  final String date;
  final String time;
  final double lat;
  final double lng;

  ExamDetailScreen({
    required this.subject,
    required this.date,
    required this.time,
    required this.lat,
    required this.lng,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Details'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(subject, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Date: $date\nTime: $time'),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('examMarker'),
                  position: LatLng(lat, lng),
                  infoWindow: InfoWindow(title: subject, snippet: 'Date: $date\nTime: $time'),
                ),
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(lat: lat, lng: lng),
                ),
              );
            },
            child: Text('Open Map'),
          ),
        ],
      ),
    );
  }
}

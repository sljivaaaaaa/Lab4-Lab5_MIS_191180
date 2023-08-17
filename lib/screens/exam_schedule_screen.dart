import 'package:flutter/material.dart';
import 'package:lab3/widgets/add_schedule_form.dart';
import 'package:lab3/screens/map_screen.dart';
import 'package:lab3/screens/exam_detail_screen.dart';

class ExamScheduleScreen extends StatefulWidget {
  @override
  _ExamScheduleScreenState createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  List<Map<String, String?>> exams = [
    {'subject': 'Math', 'date': '2023-08-15', 'time': '09:00 AM', 'lat': '37.7749', 'lng': '-122.4194'},
    {'subject': 'Physics', 'date': '2023-08-16', 'time': '10:30 AM', 'lat': '37.7749', 'lng': '-122.4194'},
    {'subject': 'Chemistry', 'date': '2023-08-17', 'time': '02:00 PM', 'lat': '37.7749', 'lng': '-122.4194'},
    // Other predefined exams
  ];

  void _openAddScheduleSegment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              AddScheduleForm(
                onSubjectAdded: (newSubject, newDate, newTime) {
                  setState(() {
                    exams.add({'subject': newSubject, 'date': newDate, 'time': newTime});
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _openAddScheduleSegment(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notif');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: 8), // Add spacing between the items
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        lat: double.parse(exams[index]['lat'] ?? '0'),
                        lng: double.parse(exams[index]['lng'] ?? '0'),
                      ),
                    ),
                  );
                },
                child: Text('Open Map'),
              ),
              SizedBox(height: 2), // Add smaller spacing
              ListTile(
                title: Text(exams[index]['subject'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Date: ${exams[index]['date'] ?? ''}\nTime: ${exams[index]['time'] ?? ''}',
                ),
              ),
              SizedBox(height: 2), // Add spacing between exam entries
            ],
          );
        },
      ),
    );
  }
}

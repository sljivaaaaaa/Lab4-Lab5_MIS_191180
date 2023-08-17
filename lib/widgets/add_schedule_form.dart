import 'package:flutter/material.dart';
import 'package:lab3/screens/calendar_screen.dart'; // Import the CalendarScreen widget
import 'package:lab3/screens/notification_screen.dart'; // Import the NotificationsScreen widget

class AddScheduleForm extends StatefulWidget {
  final Function(String, String, String) onSubjectAdded;

  AddScheduleForm({required this.onSubjectAdded});

  @override
  _AddScheduleFormState createState() => _AddScheduleFormState();
}

class _AddScheduleFormState extends State<AddScheduleForm> {
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: subjectNameController,
          decoration: InputDecoration(labelText: 'Subject Name'),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: dateController,
          decoration: InputDecoration(labelText: 'Date'),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: timeController,
          decoration: InputDecoration(labelText: 'Time'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            String newSubject = subjectNameController.text;
            String newDate = dateController.text;
            String newTime = timeController.text;

            if (newSubject.isNotEmpty && newDate.isNotEmpty && newTime.isNotEmpty) {
              // Call the provided callback to add the new exam
              widget.onSubjectAdded(newSubject, newDate, newTime);

              // Clear text controllers and close the bottom sheet
              subjectNameController.clear();
              dateController.clear();
              timeController.clear();
              Navigator.pop(context);
            }
          },
          child: Text('Add Schedule'),
        ),
        SizedBox(height: 16), // Add some spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              child: Text('Calendar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notif');
              },
              child: Text('Notifications'),
            ),
          ],
        ),
      ],
    );
  }
}

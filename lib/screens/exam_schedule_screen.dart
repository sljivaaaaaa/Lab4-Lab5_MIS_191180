import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../widgets/add_schedule_form.dart';
import '../widgets/exam_schedule_list.dart';
import '../screens/calendar_screen.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ExamScheduleScreen extends StatefulWidget {
  @override
  _ExamScheduleScreenState createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  List<Map<String, String?>> exams = [
    {'subject': 'Math', 'date': '2023-08-15', 'time': '09:00 AM'},
    {'subject': 'History', 'date': '2023-08-17', 'time': '10:30 AM'},
    {'subject': 'Physics', 'date': '2023-08-20', 'time': '02:00 PM'},
  ]; // Predefined exams

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

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

  void _showSingleNotification(Map<String, String?> exam) async {
    final String subject = exam['subject'] ?? 'No Subject';
    final String time = exam['time'] ?? 'No Time';
    final String date = exam['date'] ?? 'No Date';

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'exam_schedule_channel',
      'Exam Schedule Notifications',

      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Exam Reminder',
      'You have an exam on $date at $time for $subject.',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    if (!authService.isLoggedIn) {
      return LoginScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _openAddScheduleSegment(context);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarScreen(exams: exams)),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  for (var exam in exams) {
                    _showSingleNotification(exam);
                  }
                },
              ),
            ),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(exams[index]['subject'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Date: ${exams[index]['date'] ?? ''}\nTime: ${exams[index]['time'] ?? ''}',
              ),
            ),
          );
        },
      ),
    );
  }
}

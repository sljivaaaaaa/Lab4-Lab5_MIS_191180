import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/exam_schedule_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'screens/calendar_screen.dart';
import 'screens/notification_screen.dart'; // Correct the import path

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, String?>> exams = [  // Define the exams list here
    {'subject': 'Math', 'date': '2023-08-15', 'time': '09:00 AM', 'lat': '37.7749', 'lng': '-122.4194'},
    {'subject': 'Physics', 'date': '2023-08-16', 'time': '10:30 AM', 'lat': '37.7749', 'lng': '-122.4194'},
    {'subject': 'Chemistry', 'date': '2023-08-17', 'time': '02:00 PM', 'lat': '37.7749', 'lng': '-122.4194'},
    // Other predefined exams
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Exam Schedule App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/main': (context) => ExamScheduleScreen(), // Pass the exams list to ExamScheduleScreen
          '/calendar': (context) => CalendarScreen(exams: exams),
          '/notif': (context) => NotificationsScreen(),
        },
      ),
    );
  }
}

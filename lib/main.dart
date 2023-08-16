import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/exam_schedule_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'screens/exam_schedule_screen.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          '/main': (context) => ExamScheduleScreen(),
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';


class ExamScheduleList extends StatelessWidget {
  final List<Map<String, String?>> exams;
  final DateTime selectedDay;

  ExamScheduleList({required this.exams, required this.selectedDay});

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final filteredExams = exams.where((exam) {
      final examDate = DateTime.parse(exam['date']!);
      return isSameDay(examDate, selectedDay);
    }).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredExams.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(filteredExams[index]['subject'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Time: ${filteredExams[index]['time'] ?? ''}',
              ),
            ),
          );
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:ulis_ync/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(task.description),
            SizedBox(height: 8.0),
            Text('Status: ${task.status}'),
            SizedBox(height: 8.0),
            Text('Deadline: ${task.deadline}'),
            SizedBox(height: 8.0),
            Text('Submission Date: ${task.timeSubmitted}'),
          ],
        ),
      ),
    );
  }
}
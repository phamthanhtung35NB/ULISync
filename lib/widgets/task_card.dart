import 'package:flutter/material.dart';
import 'package:ulis_ync/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});
  Color _getTaskColor(Task task) {
    print(task.status);
    if (task.status == 'đã hoàn thành') {
      return Colors.green;
    // } else if (task.deadline.isBefore(DateTime.now())) {
    } else if (task.status == 'Thiếu') {
      return Colors.red;

    } else {
      return Colors.yellow;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: _getTaskColor(task),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // color: _getTaskColor(task),
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

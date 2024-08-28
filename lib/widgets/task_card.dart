import 'package:flutter/material.dart';
import 'package:ulis_ync/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});
  Color _getTaskColor(Task task) {
    print(task.status);
    if (task.status == 'Đã hoàn thành') {
      return Color(0xFFB4F6A4);
    // } else if (task.deadline.isBefore(DateTime.now())) {
    } else if (task.status == 'Quá hạn') {
      //A93932FF
      return Color(0xFFF898A4);

    } else if (task.status == 'Đang tiến hành') {
      return Color(0xFFF7FAA1);
    } else {
      return Colors.blue;
    }
  }
@override
Widget build(BuildContext context) {
  return Stack(
    children: [
      Positioned(
        child: Padding(
          padding: const EdgeInsets.only(right: 19.0,left: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Container(
              width: double.infinity - 8,
              //nhỏ hơn 10
              height:  177,
              color: _getTaskColor(task),
            ),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
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
        ),
      ),
    ],
  );
}
}

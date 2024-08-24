import 'package:flutter/material.dart';
import 'package:ulis_ync/model/task.dart';

class TaskDetailScreen extends StatefulWidget {
  final List<Task> tasks;

  const TaskDetailScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _addTask() {
    setState(() {
      widget.tasks.add(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New Task',
        description: 'Description for new task',
        status: 'chưa hoàn thành',
        deadline: DateTime.now().add(Duration(days: 5)),
        timeSubmitted: DateTime.now(),
        linkFile: '',
        linkImage: '',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tasks.first.title.split(' for ').last),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          Task task = widget.tasks[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Title: ${task.title}', style: TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            widget.tasks.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text('Description: ${task.description}'),
                  SizedBox(height: 8.0),
                  Text('Status: ${task.status}'),
                  SizedBox(height: 8.0),
                  Text('Deadline: ${task.deadline}'),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _linkController,
                    decoration: InputDecoration(
                      labelText: 'Link bài viết',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      labelText: 'Link ảnh',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        task.linkFile = _linkController.text;
                        task.linkImage = _imageController.text;
                        task.isLinkFile = _linkController.text.isNotEmpty;
                        task.isLinkImage = _imageController.text.isNotEmpty;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task submitted successfully')),
                      );
                    },
                    child: Text('Nộp bài'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
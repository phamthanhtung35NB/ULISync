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

  void _showTaskOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Options'),
          content: Text('Do you want to delete or edit this task?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  widget.tasks.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditTaskDialog(index);
              },
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(int index) {
    Task task = widget.tasks[index];
    TextEditingController titleController = TextEditingController(text: task.title);
    TextEditingController descriptionController = TextEditingController(text: task.description);
    TextEditingController statusController = TextEditingController(text: task.status);
    TextEditingController deadlineController = TextEditingController(text: task.deadline.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
              TextField(
                controller: deadlineController,
                decoration: InputDecoration(labelText: 'Deadline'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  task.title = titleController.text;
                  task.description = descriptionController.text;
                  task.status = statusController.text;
                  task.deadline = DateTime.parse(deadlineController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
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
                        icon: Icon(Icons.more_vert),
                        onPressed: () => _showTaskOptionsDialog(index),
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
                  TextFormField(
                    controller: _linkController,
                    decoration: InputDecoration(
                      labelText: 'Link bài viết',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
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
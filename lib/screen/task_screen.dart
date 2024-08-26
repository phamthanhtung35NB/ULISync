import 'package:flutter/material.dart';
import 'package:ulis_ync/model/task.dart';
import 'package:ulis_ync/services/firestore_service.dart';

class TaskScreen extends StatefulWidget {
  final String groupId;
  final String userId;

  const TaskScreen({Key? key, required this.groupId, required this.userId}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    // Load tasks from Firestore
  }

  Future<void> _createTask(String title, String description, DateTime deadline, String assignedTo) async {
    Task task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      status: 'chưa hoàn thành',
      deadline: deadline,
      timeSubmitted: DateTime.now(),
      linkFile: '',
      isLinkFile: false,
      linkImage: '',
      isLinkImage: false,
      assignedTo: assignedTo,
    );
    await _firestoreService.addTask(task);
    _loadTasks();
  }

  Future<void> _updateTask(Task task) async {
    await _firestoreService.updateTask(task);
    _loadTasks();
  }

  Future<void> _deleteTask(String taskId) async {
    await _firestoreService.deleteTask(taskId);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          Task task = _tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: widget.userId == task.assignedTo || widget.userId == task.ownerId
                ? PopupMenuButton<String>(
                    onSelected: (String value) {
                      switch (value) {
                        case 'Edit':
                          // Show edit dialog
                          break;
                        case 'Delete':
                          _deleteTask(task.id);
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Delete'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )
                : null,
          );
        },
      ),
      floatingActionButton: widget.userId == task.ownerId
          ? FloatingActionButton(
              onPressed: () {
                // Show create task dialog
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
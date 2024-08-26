import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ulis_ync/model/task.dart';
import 'package:ulis_ync/services/firestore_service.dart';
import 'package:ulis_ync/widgets/task_card.dart';

class TaskDetailScreen extends StatefulWidget {
  final String groupId;

  TaskDetailScreen({required this.groupId});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Task> _tasks = [];
  List<String> _members = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadMembers();
  }

  Future<void> _loadTasks() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('tasks').where('groupId', isEqualTo: widget.groupId).get();
    setState(() {
      _tasks = snapshot.docs.map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Future<void> _loadMembers() async {
    DocumentSnapshot groupDoc = await FirebaseFirestore.instance.collection('groups').doc(widget.groupId).get();
    if (groupDoc.exists) {
      setState(() {
        _members = List<String>.from(groupDoc['students']);
      });
    }
  }

  Future<void> _addMember() async {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Member Email'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _firestoreService.addMemberToGroup(widget.groupId, emailController.text);
                _loadMembers();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
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

  Future<void> _createNewTask() async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                Task newTask = Task(
                  id: id,
                  title: titleController.text,
                  description: descriptionController.text,
                  groupId: widget.groupId,
                  deadline: DateTime.now().add(Duration(days: 7)), // Example deadline
                  timeSubmitted: DateTime.now(),
                );
                await _firestoreService.addTask(newTask);
                _loadTasks();
                Navigator.of(context).pop();
              },
              child: Text('Create'),
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

  void _showTaskOptionsDialog(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Options'),
          content: Text('Do you want to submit or edit this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSubmitTaskDialog(task);
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditTaskDialog(task);
              },
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  void _showSubmitTaskDialog(Task task) {
    TextEditingController linkController = TextEditingController();
    TextEditingController imageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: linkController,
                decoration: InputDecoration(labelText: 'Link bài viết'),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Link ảnh'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {
                  task.linkFile = linkController.text;
                  task.linkImage = imageController.text;
                  task.isLinkFile = linkController.text.isNotEmpty;
                  task.isLinkImage = imageController.text.isNotEmpty;
                });
                await _firestoreService.updateTask(task);
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
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

  void _showEditTaskDialog(Task task) {
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
              onPressed: () async {
                setState(() {
                  task.title = titleController.text;
                  task.description = descriptionController.text;
                  task.status = statusController.text;
                  task.deadline = DateTime.parse(deadlineController.text);
                });
                await _firestoreService.updateTask(task);
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
        title: Text('Tasks'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addMember,
            child: Text('Add Member'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_members[index]),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _showTaskOptionsDialog(_tasks[index]),
                  child: TaskCard(task: _tasks[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
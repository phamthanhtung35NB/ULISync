import 'package:flutter/material.dart';
import 'package:ulis_ync/screen/custom_drawer.dart';
import 'package:ulis_ync/screen/task_detail_screen.dart';
import 'package:ulis_ync/model/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<Task>> teamTasks = [
      [
        Task(
          id: '1',
          title: 'Task 1 for ELT 1 - GROUP 1',
          description: 'Description for Task 1',
          status: 'chưa hoàn thành',
          deadline: DateTime.now().add(Duration(days: 5)),
          timeSubmitted: DateTime.now(),
          linkFile: '',
          linkImage: '',
        ),
        Task(
          id: '2',
          title: 'Task 2 for ELT 1 - GROUP 1',
          description: 'Description for Task 2',
          status: 'chưa hoàn thành',
          deadline: DateTime.now().add(Duration(days: 5)),
          timeSubmitted: DateTime.now(),
          linkFile: '',
          linkImage: '',
        ),
      ],
      [
        Task(
          id: '3',
          title: 'Task 1 for GEO 4 - GROUP 6',
          description: 'Description for Task 1',
          status: 'chưa hoàn thành',
          deadline: DateTime.now().add(Duration(days: 5)),
          timeSubmitted: DateTime.now(),
          linkFile: '',
          linkImage: '',
        ),
      ],
      [
        Task(
          id: '4',
          title: 'Task 1 for LING 2 - GROUP 2',
          description: 'Description for Task 1',
          status: 'chưa hoàn thành',
          deadline: DateTime.now().add(Duration(days: 5)),
          timeSubmitted: DateTime.now(),
          linkFile: '',
          linkImage: '',
        ),
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('Home'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'YOUR TEAMS:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
              childAspectRatio: 2.5,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: teamTasks.map((tasks) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailScreen(tasks: tasks),
                      ),
                    );
                  },
                  child: TeamCard(tasks: tasks),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final List<Task> tasks;

  const TeamCard({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/images/team1.jpg', fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tasks.first.title.split(' for ').last, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
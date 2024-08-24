import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ulis_ync/screen/custom_drawer.dart';
import 'package:ulis_ync/screen/task_detail_screen.dart';
import 'package:ulis_ync/model/task.dart';
import 'package:ulis_ync/model/group.dart';
import 'package:ulis_ync/model/student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  String email = 'No email';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? 'No email';
  }

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

  List<Group> groups = [
    Group(
      id: '1',
      name: 'ELT 1 - GROUP 1',
      description: 'Description for ELT 1 - GROUP 1',
      image: 'assets/images/team1.jpg',
      students: [
        Student(id: '1', name: 'Student 1', email: 'student1@vnu.edu.vn'),
        Student(id: '2', name: 'Student 2', email: 'student2@vnu.edu.vn'),
      ],
    ),
    Group(
      id: '2',
      name: 'GEO 4 - GROUP 6',
      description: 'Description for GEO 4 - GROUP 6',
      image: 'assets/images/team2.jpg',
      students: [
        Student(id: '3', name: 'Student 3', email: 'student3@vnu.edu.vn'),
      ],
    ),
    Group(
      id: '3',
      name: 'LING 2 - GROUP 2',
      description: 'Description for LING 2 - GROUP 2',
      image: 'assets/images/team3.jpg',
      students: [
        Student(id: '4', name: 'Student 4', email: 'student4@vnu.edu.vn'),
      ],
    ),
  ];

  void _createNewTeam() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController teamNameController = TextEditingController();
        return AlertDialog(
          title: Text('Create New Team'),
          content: TextField(
            controller: teamNameController,
            decoration: InputDecoration(labelText: 'Team Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  teamTasks.add([
                    Task(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: 'Task 1 for ${teamNameController.text}',
                      description: 'Description for Task 1',
                      status: 'chưa hoàn thành',
                      deadline: DateTime.now().add(Duration(days: 5)),
                      timeSubmitted: DateTime.now(),
                      linkFile: '',
                      linkImage: '',
                    ),
                  ]);
                  groups.add(
                    Group(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: teamNameController.text,
                      description: 'Description for ${teamNameController.text}',
                      image: 'assets/images/team1.jpg',
                      students: [],
                    ),
                  );
                });
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

  @override
  Widget build(BuildContext context) {
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
        title: Row(
          children: [
            TextButton(
              child: Text('Home', style: TextStyle(color: Colors.grey)),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Projects', style: TextStyle(color: Colors.grey)),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Planning', style: TextStyle(color: Colors.grey)),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Reports', style: TextStyle(color: Colors.grey)),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Calendar', style: TextStyle(color: Colors.grey)),
              onPressed: () {},
            ),
            TextButton(
              child: Text('People', style: TextStyle(color: Colors.grey)),
              onPressed: () {},
            ),
          ],
        ),
        actions: [
          Container(
            width: 200,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Here',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
                ),
                SizedBox(height: 2),
                Text(
                  email,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTeam,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final List<Task> tasks;

  const TeamCard({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ELT 1 - GROUP 1',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    switch (value) {
                      case 'Add Member':
                        _showAddMemberDialog(context);
                        break;
                      case 'Edit Group':
                        _showEditGroupDialog(context);
                        break;
                      case 'Delete Group':
                        _deleteGroup(context);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Add Member', 'Edit Group', 'Delete Group'}.map((
                        String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Member'),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
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

  void _showEditGroupDialog(BuildContext context) {
    TextEditingController groupNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Group'),
          content: TextField(
            controller: groupNameController,
            decoration: InputDecoration(labelText: 'Group Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],);
      },);
  }
}

class _deleteGroup {
  _deleteGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Group'),
          content: Text('Are you sure you want to delete this group?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
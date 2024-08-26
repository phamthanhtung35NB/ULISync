import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ulis_ync/model/group.dart';
import 'package:ulis_ync/screen/task_detail_screen.dart';
import 'package:ulis_ync/services/firestore_service.dart';
import 'custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Group> _groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('groups').get();
    setState(() {
      _groups = snapshot.docs.map((doc) => Group.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Future<void> _createNewGroup() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Group'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Group Name'),
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
                Group newGroup = Group(
                  id: id,
                  name: nameController.text,
                  description: descriptionController.text,
                  image: 'assets/images/team1.jpg',
                  ownerId: 'currentUserId', // Replace with actual user ID
                  students: [],
                );
                await _firestoreService.createGroup(newGroup);
                _loadGroups();
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
            // Add other buttons here
          ],
        ),
        actions: [
          // Add search bar and other actions here
        ],
      ),
      drawer: CustomDrawer(),
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
              children: _groups.map((group) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailScreen(groupId: group.id),
                      ),
                    );
                  },
                  child: TeamCard(group: group),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewGroup,
        child: Icon(Icons.add),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ulis_ync/model/group.dart';
// import 'package:ulis_ync/screen/task_detail_screen.dart';
// import 'package:ulis_ync/services/firestore_service.dart';
// import 'custom_drawer.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final FirestoreService _firestoreService = FirestoreService();
//   List<Group> _groups = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadGroups();
//   }
//
//   Future<void> _loadGroups() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('groups').get();
//     setState(() {
//       _groups = snapshot.docs.map((doc) => Group.fromMap(doc.data() as Map<String, dynamic>)).toList();
//     });
//   }
//
//   Future<void> _createNewGroup() async {
//     // Implement group creation logic
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Builder(
//           builder: (BuildContext context) {
//             return IconButton(
//               icon: const Icon(Icons.menu),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             );
//           },
//         ),
//         title: Row(
//           children: [
//             TextButton(
//               child: Text('Home', style: TextStyle(color: Colors.grey)),
//               onPressed: () {},
//             ),
//             // Add other buttons here
//           ],
//         ),
//         actions: [
//           // Add search bar and other actions here
//         ],
//       ),
//       drawer: CustomDrawer(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'YOUR TEAMS:',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 3,
//               padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
//               childAspectRatio: 2.5,
//               mainAxisSpacing: 8.0,
//               crossAxisSpacing: 8.0,
//               children: _groups.map((group) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TaskDetailScreen(groupId: group.id),
//                       ),
//                     );
//                   },
//                   child: TeamCard(group: group),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _createNewGroup,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
class TeamCard extends StatelessWidget {
  final Group group;

  const TeamCard({super.key, required this.group});

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
                Text(group.name, style: TextStyle(fontWeight: FontWeight.bold)),
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
                    return {'Add Member', 'Edit Group', 'Delete Group'}.map((String choice) {
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
//
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
          ],
        );
      },
    );
  }

  void _deleteGroup(BuildContext context) {
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
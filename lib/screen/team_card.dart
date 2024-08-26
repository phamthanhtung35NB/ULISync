import 'package:flutter/material.dart';
import 'package:ulis_ync/model/group.dart';
import 'package:ulis_ync/services/firestore_service.dart';

class TeamCard extends StatelessWidget {
  final Group group;
  final FirestoreService _firestoreService = FirestoreService();

  TeamCard({Key? key, required this.group}) : super(key: key);

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
                child: Image.asset(group.image, fit: BoxFit.cover),
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
              onPressed: () async {
                String email = emailController.text;
                await _firestoreService.addMemberToGroup(group.id, email);
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
    TextEditingController groupNameController = TextEditingController(text: group.name);
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
              onPressed: () async {
                group.name = groupNameController.text;
                await _firestoreService.updateGroup(group);
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

  void _deleteGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Group'),
          content: Text('Are you sure you want to delete this group?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _firestoreService.deleteGroup(group.id);
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


// import 'package:flutter/material.dart';
// import 'package:ulis_ync/model/task.dart';
// import 'package:ulis_ync/model/group.dart';
// import 'package:ulis_ync/model/student.dart';
//
// class TeamCard extends StatelessWidget {
//   final List<Task> tasks;
//   final Group group;
//
//   const TeamCard({Key? key, required this.tasks, required this.group}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       elevation: 4,
//       child: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(group.image, fit: BoxFit.cover),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(group.name, style: TextStyle(fontWeight: FontWeight.bold)),
//                   PopupMenuButton<String>(
//                     onSelected: (String value) {
//                       switch (value) {
//                         case 'Add Member':
//                           _showAddMemberDialog(context);
//                           break;
//                         case 'Edit Group':
//                           _showEditGroupDialog(context);
//                           break;
//                         case 'Delete Group':
//                           _deleteGroup(context);
//                           break;
//                       }
//                     },
//                     itemBuilder: (BuildContext context) {
//                       return {'Add Member', 'Edit Group', 'Delete Group'}.map((String choice) {
//                         return PopupMenuItem<String>(
//                           value: choice,
//                           child: Text(choice),
//                         );
//                       }).toList();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddMemberDialog(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add Member'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               SizedBox(height: 10),
//               Text('Current Members:'),
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: group.students.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(group.students[index].name),
//                       subtitle: Text(group.students[index].email),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Add member logic here
//                 Navigator.of(context).pop();
//               },
//               child: Text('Done'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showEditGroupDialog(BuildContext context) {
//     // Edit group logic here
//   }
//
//   void _deleteGroup(BuildContext context) {
//     // Delete group logic here
//   }
// }
import 'package:flutter/material.dart';
import 'package:ulis_ync/model/group.dart';
import 'package:ulis_ync/services/firestore_service.dart';

class GroupScreen extends StatefulWidget {
  final String userId;

  const GroupScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Group> _groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    // Load groups from Firestore
  }

  Future<void> _createGroup(String name, String description) async {
    Group group = Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      image: 'assets/images/team1.jpg',
      ownerId: widget.userId,
      students: [],
    );
    await _firestoreService.createGroup(group);
    _loadGroups();
  }

  Future<void> _updateGroup(Group group) async {
    await _firestoreService.updateGroup(group);
    _loadGroups();
  }

  Future<void> _deleteGroup(String groupId) async {
    await _firestoreService.deleteGroup(groupId);
    _loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
      ),
      body: ListView.builder(
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          Group group = _groups[index];
          return ListTile(
            title: Text(group.name),
            subtitle: Text(group.description),
            trailing: widget.userId == group.ownerId
                ? PopupMenuButton<String>(
                    onSelected: (String value) {
                      switch (value) {
                        case 'Edit':
                          // Show edit dialog
                          break;
                        case 'Delete':
                          _deleteGroup(group.id);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show create group dialog
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user;
  String email = 'No email';
  String _selectedLanguage = 'Tiếng Việt'; // Default language

  @override
  void initState() {
    super.initState();
    _loadGroups();
    user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? 'No email';
  }

  Future<void> _loadGroups() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('groups').get();
    setState(() {
      _groups = snapshot.docs
          .map((doc) => Group.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> _createNewGroup() async {
    TextEditingController groupNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Group'),
          content: TextField(
            controller: groupNameController,
            decoration: InputDecoration(labelText: 'Group Name'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String groupName = groupNameController.text;
                if (groupName.isNotEmpty) {
                  await FirebaseFirestore.instance.collection('groups').add({
                    'name': groupName,
                  });
                  _loadGroups();
                }
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
              child: Text('Home', style: TextStyle(color: Colors.black)),
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
            // DropdownButton<String>(
            //   value: _selectedLanguage,
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedLanguage = newValue!;
            //     });
            //   },
            //   items: <String>[
            //     'Tiếng Việt',
            //     'Tiếng Anh',
            //     'Tiếng Trung',
            //     'Tiếng Hàn',
            //     'Tiếng Nhật',
            //     'Tiếng Pháp',
            //     'Tiếng Đức',
            //     'Tiếng Nga',
            //     'Tiếng Ả Rập'
            //   ].map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            // ),
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
                  backgroundImage: AssetImage('assets/images/app_logo.png'),
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
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'YOUR TEAMS:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.double,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 8.0),
              childAspectRatio: 2.5,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: _groups.map((group) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TaskDetailScreen(groupId: group.id),
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

class TeamCard extends StatelessWidget {
  final Group group;

  const TeamCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      padding: const EdgeInsets.all(1.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child: Image.asset('assets/images/app_logo.png',
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(group.name,
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
                        return {'Add Member', 'Edit Group', 'Delete Group'}
                            .map((String choice) {
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
// class TeamCard extends StatelessWidget {
//   final Group group;
//
//   const TeamCard({super.key, required this.group});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200, // Chiều rộng của thẻ
//       height: 300, // Chiều cao của thẻ
//       padding: const EdgeInsets.all(1.0), // Khoảng cách đệm xung quanh nội dung
//       child: AspectRatio(
//         aspectRatio: 1, // Đảm bảo thẻ có tỷ lệ khung hình là hình vuông
//         child: Card(
//           elevation: 10, // Độ cao của thẻ, tạo hiệu ứng bóng đổ
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8), // Bo tròn các góc của thẻ
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: AspectRatio(
//                   aspectRatio: 2.2,
//                   // Đảm bảo hình ảnh có tỷ lệ khung hình là hình vuông
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(1),
//                     // Bo tròn các góc của hình ảnh
//                     child: Image.asset('assets/images/app_logo.png',
//                         fit: BoxFit
//                             .cover), // Hiển thị hình ảnh từ tài nguyên với chế độ bao phủ
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 // Khoảng cách đệm xung quanh nội dung
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   // Căn chỉnh các phần tử trong hàng
//                   children: [
//                     Text(group.name,
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     // Hiển thị tên nhóm với kiểu chữ đậm
//                     PopupMenuButton<String>(
//                       onSelected: (String value) {
//                         switch (value) {
//                           case 'Add Member':
//                             _showAddMemberDialog(
//                                 context); // Hiển thị hộp thoại thêm thành viên
//                             break;
//                           case 'Edit Group':
//                             _showEditGroupDialog(
//                                 context); // Hiển thị hộp thoại chỉnh sửa nhóm
//                             break;
//                           case 'Delete Group':
//                             _deleteGroup(
//                                 context); // Hiển thị hộp thoại xóa nhóm
//                             break;
//                         }
//                       },
//                       itemBuilder: (BuildContext context) {
//                         return {'Add Member', 'Edit Group', 'Delete Group'}
//                             .map((String choice) {
//                           return PopupMenuItem<String>(
//                             value: choice,
//                             child: Text(
//                                 choice), // Hiển thị các lựa chọn trong menu
//                           );
//                         }).toList();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
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
//           title: Text('Add Member'), // Tiêu đề của hộp thoại
//           content: TextField(
//             controller: emailController,
//             decoration:
//                 InputDecoration(labelText: 'Email'), // Trường nhập email
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Đóng hộp thoại
//               },
//               child: Text('Add'), // Nút thêm thành viên
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Đóng hộp thoại
//               },
//               child: Text('Cancel'), // Nút hủy bỏ
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showEditGroupDialog(BuildContext context) {
//     TextEditingController groupNameController = TextEditingController();
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Edit Group'), // Tiêu đề của hộp thoại
//           content: TextField(
//             controller: groupNameController,
//             decoration: InputDecoration(
//                 labelText: 'Group Name'), // Trường nhập tên nhóm
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Đóng hộp thoại
//               },
//               child: Text('Edit'), // Nút chỉnh sửa nhóm
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Đóng hộp thoại
//               },
//               child: Text('Cancel'), // Nút hủy bỏ
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _deleteGroup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Group'),
//           // Tiêu đề của hộp thoại
//           content: Text('Are you sure you want to delete this group?'),
//           // Nội dung xác nhận xóa nhóm
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Đóng hộp thoại
//               },
//               child: Text('Yes'), // Nút xác nhận xóa
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Đóng hộp thoại
//               },
//               child: Text('No'), // Nút hủy bỏ
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

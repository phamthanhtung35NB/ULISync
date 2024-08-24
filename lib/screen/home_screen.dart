// import 'package:flutter/material.dart';
// import 'package:ulis_ync/screen/custom_drawer.dart';
// import 'package:ulis_ync/screen/task_detail_screen.dart';
// import 'package:ulis_ync/model/task.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List<List<Task>> teamTasks = [
//       [
//         Task(
//           id: '1',
//           title: 'Task 1 for ELT 1 - GROUP 1',
//           description: 'Description for Task 1',
//           status: 'chưa hoàn thành',
//           deadline: DateTime.now().add(Duration(days: 5)),
//           timeSubmitted: DateTime.now(),
//           linkFile: '',
//           linkImage: '',
//         ),
//         Task(
//           id: '2',
//           title: 'Task 2 for ELT 1 - GROUP 1',
//           description: 'Description for Task 2',
//           status: 'chưa hoàn thành',
//           deadline: DateTime.now().add(Duration(days: 5)),
//           timeSubmitted: DateTime.now(),
//           linkFile: '',
//           linkImage: '',
//         ),
//       ],
//       [
//         Task(
//           id: '3',
//           title: 'Task 1 for GEO 4 - GROUP 6',
//           description: 'Description for Task 1',
//           status: 'chưa hoàn thành',
//           deadline: DateTime.now().add(Duration(days: 5)),
//           timeSubmitted: DateTime.now(),
//           linkFile: '',
//           linkImage: '',
//         ),
//       ],
//       [
//         Task(
//           id: '4',
//           title: 'Task 1 for LING 2 - GROUP 2',
//           description: 'Description for Task 1',
//           status: 'chưa hoàn thành',
//           deadline: DateTime.now().add(Duration(days: 5)),
//           timeSubmitted: DateTime.now(),
//           linkFile: '',
//           linkImage: '',
//         ),
//       ],
//     ];
//
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
//             TextButton(
//               child: Text('Projects', style: TextStyle(color: Colors.grey)),
//               onPressed: () {},
//             ),
//             TextButton(
//               child: Text('Planning', style: TextStyle(color: Colors.grey)),
//               onPressed: () {},
//             ),
//             TextButton(
//               child: Text('Reports', style: TextStyle(color: Colors.grey)),
//               onPressed: () {},
//             ),
//             TextButton(
//               child: Text('Calendar', style: TextStyle(color: Colors.grey)),
//               onPressed: () {},
//             ),
//             TextButton(
//               child: Text('People', style: TextStyle(color: Colors.grey)),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         actions: [
//           Container(
//             width: 200,
//             margin: EdgeInsets.symmetric(vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search Here',
//                 prefixIcon: Icon(Icons.search),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
//           IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 15,
//                   backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   '123456', // Thay bằng mã sinh viên thực tế
//                   style: TextStyle(color: Colors.black, fontSize: 10),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       drawer: const CustomDrawer(),
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
//               children: teamTasks.map((tasks) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => TaskDetailScreen(tasks: tasks),
//                       ),
//                     );
//                   },
//                   child: TeamCard(tasks: tasks),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ulis_ync/screen/custom_drawer.dart';
import 'package:ulis_ync/screen/task_detail_screen.dart';
import 'package:ulis_ync/model/task.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? 'No email';

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
                child:
                    Image.asset('assets/images/team1.jpg', fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tasks.first.title.split(' for ').last,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
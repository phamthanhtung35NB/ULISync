// import 'package:flutter/material.dart';
// import 'package:ulis_ync/screen/home_screen.dart';
//
// class CustomDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Menu',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//               );
//             },
//           ),
//           // Add more navigation items here
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ulis_ync/controller/login_controller.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final LoginController _loginController = LoginController();
  String _selectedLanguage = 'English'; // Default language

  Future<void> _changePassword() async {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController =
        TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Đổi mật khẩu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Change password logic
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(1), BlendMode.dstATop),
                  image: AssetImage('assets/images/app_logo.png'),
                ),
              ),
              child: null,
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.black),
              title: Text('My Projects', style: TextStyle(color: Colors.black)),
              onTap: () {
                // My Projects
              },
            ),
            ListTile(
              leading: Icon(Icons.flash_on, color: Colors.black),
              title: Text('Activity', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Activity
              },
            ),
            ListTile(
              leading: Icon(Icons.comment, color: Colors.black),
              title: Text('Unread Comments',
                  style: TextStyle(color: Colors.black)),
              onTap: () {
                // Unread Comments
              },
            ),
            ListTile(
              leading: Icon(Icons.message, color: Colors.black),
              title: Text('Unread Messages',
                  style: TextStyle(color: Colors.black)),
              onTap: () {
                // Unread Messages
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.black),
              title: Text('Meetings', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Meetings
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.black),
              title: Text('Add Account', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Add Account
              },
            ),
            ListTile(
              leading: Icon(Icons.swap_horiz, color: Colors.black),
              title:
                  Text('Change Password', style: TextStyle(color: Colors.black)),
              onTap: _changePassword,
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.black),
              title: Text('Change Language', style: TextStyle(color: Colors.black)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select Language'),
                      content: DropdownButton<String>(
                        value: _selectedLanguage,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                          Navigator.of(context).pop();
                        },
                        items: <String>[
                          'Vietnamese',
                          'English',
                          'Chinese',
                          'Korean',
                          'Japanese',
                          'French',
                          'German',
                          'Russian',
                          'Arabic'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black),
              title: Text('Log off', style: TextStyle(color: Colors.black)),
              onTap: () async {
                // await _loginController.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login_screen', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

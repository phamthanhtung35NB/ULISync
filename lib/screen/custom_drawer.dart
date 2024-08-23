import 'package:flutter/material.dart';
import 'package:ulis_ync/controller/login_controller.dart';

/**
 * Custom Drawer
 * Bố cục navigation drawer tùy chỉnh
 */
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = LoginController();

    Future<void> _changePassword() async {
      final TextEditingController currentPasswordController = TextEditingController();
      final TextEditingController newPasswordController = TextEditingController();

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
                    labelText: 'Mật khẩu hiện tại',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu mới',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String? result = await _loginController.changePassword(
                    currentPasswordController.text,
                    newPasswordController.text,
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result ?? 'An error occurred')),
                  );
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

    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('My Work', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.work, color: Colors.white),
              title: Text('My Projects', style: TextStyle(color: Colors.white)),
              onTap: () {
                // My Projects
              },
            ),
            ListTile(
              leading: Icon(Icons.flash_on, color: Colors.white),
              title: Text('Activity', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Activity
              },
            ),
            ListTile(
              leading: Icon(Icons.comment, color: Colors.white),
              title: Text('Unread Comments', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Unread Comments
              },
            ),
            ListTile(
              leading: Icon(Icons.message, color: Colors.white),
              title: Text('Unread Messages', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Unread Messages
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.white),
              title: Text('Meetings', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Meetings
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.person_add, color: Colors.white),
              title: Text('Add Account', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Add Account
              },
            ),
            ListTile(
              leading: Icon(Icons.swap_horiz, color: Colors.white),
              title: Text('Đổi mật khẩu', style: TextStyle(color: Colors.white)),
              onTap: _changePassword,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text('Đăng xuất', style: TextStyle(color: Colors.white)),
              onTap: () async {
                // await _loginController.logout();
                Navigator.of(context).pushNamedAndRemoveUntil('/login_screen', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
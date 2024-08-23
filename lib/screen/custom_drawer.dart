import 'package:flutter/material.dart';

/**
 * Custom Drawer
 * Bố cục navigation drawer tùy chỉnh
 */
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              title: Text('Switch Account', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Switch Account
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text('Log Out', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Log Out
              },
            ),
          ],
        ),
      ),
    );
  }
}
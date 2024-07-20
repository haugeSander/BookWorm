import 'package:book_worm/screens/edit_user.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const EditUserPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Account Settings'),
            onTap: () {
              // TODO: Implement account settings functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // TODO: Implement notifications settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy and Security'),
            onTap: () {
              // TODO: Implement privacy and security settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help and Support'),
            onTap: () {
              // TODO: Implement help and support functionality
            },
          ),
        ],
      ),
    );
  }
}

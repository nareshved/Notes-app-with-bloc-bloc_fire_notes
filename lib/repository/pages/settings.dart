import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 40,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
              child: const Icon(
                CupertinoIcons.person,
                size: 30,
              ),
            ),
          ),
          Divider(
            thickness: 0.6,
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text("dark Mode"),
            subtitle: const Text("Change app theme to Dark Mode"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text("Log Out"),
            subtitle: const Text("exit to app"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

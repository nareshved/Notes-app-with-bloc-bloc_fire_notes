import 'dart:developer';

import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:bloc_fire_notes/data/theme_provider/dark_theme_provider.dart';
import 'package:bloc_fire_notes/repository/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  Theme.of(context).colorScheme.primary.withOpacity(0.4),
              child: const Icon(
                CupertinoIcons.person,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          const Text(
            "Created By Naresh VED ❤",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15.h,
          ),
          const Divider(
            thickness: 0.3,
          ),
          SizedBox(
            height: 15.h,
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text("dark Mode"),
            subtitle: const Text("Change app theme to Dark Mode"),
            trailing: Switch.adaptive(
              value: context.watch<ThemeProvider>().themeValue,
              onChanged: (value) {
                context.read<ThemeProvider>().themeValue = value;
              },
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text("Log Out"),
            subtitle: const Text("exit to app"),
            onTap: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setString(FirebaseProvider.loginPrefsKey, "");
              log("user logout");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

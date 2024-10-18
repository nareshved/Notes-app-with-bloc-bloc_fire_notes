import 'package:bloc_fire_notes/repository/pages/home_page.dart';
import 'package:bloc_fire_notes/repository/pages/settings.dart';
import 'package:flutter/material.dart';

class HomeBottomNavbar extends StatefulWidget {
  const HomeBottomNavbar({super.key});

  @override
  State<HomeBottomNavbar> createState() => _HomeBottomNavbarState();
}

class _HomeBottomNavbarState extends State<HomeBottomNavbar> {
  List<Widget> appPages = [
    HomePage(),
    const SettingsPage(),
  ];

  int mSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.deepOrange,
        selectedIndex: mSelectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            mSelectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.edit),
            label: "Notes",
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: appPages[mSelectedIndex],
    );
  }
}

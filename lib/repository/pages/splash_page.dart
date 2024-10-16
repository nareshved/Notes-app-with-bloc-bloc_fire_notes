import 'dart:async';
import 'dart:developer';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:bloc_fire_notes/repository/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/home/bottom_nav_bar/bottom_nav_bar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () async {
        var prefs = await SharedPreferences.getInstance();
        String? myKey = prefs.getString(FirebaseProvider.loginPrefsKey);

        log("my firebase uid ---- ${myKey.toString()}");

        Widget navigateTo = LoginPage();

        if (myKey != null && myKey != "") {
          // ignore: prefer_const_constructors
          navigateTo = HomeBottomNavbar();
        }
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => navigateTo,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app-logo.png",
              width: 250,
            )
          ],
        ),
      ),
    );
  }
}

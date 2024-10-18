import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_bloc.dart';
import 'package:bloc_fire_notes/data/bloc/register_user/register_bloc.dart';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:bloc_fire_notes/data/theme_provider/dark_theme_provider.dart';
import 'package:bloc_fire_notes/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'repository/pages/splash_page.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RegisterBloc(firebaseProvider: FirebaseProvider()),
        ),
        BlocProvider(
          create: (context) => NoteBloc(firebaseProvider: FirebaseProvider()),
        )
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        // themeAnimationDuration: const Duration(milliseconds: 800),

        themeAnimationDuration: const Duration(seconds: 1),
        themeAnimationCurve: Curves.easeInCirc,
        darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: "Merienda",
            colorScheme: const ColorScheme.dark(
              primary: Colors.deepOrange,
            )),
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: "Merienda",
            colorScheme: const ColorScheme.light(
              primary: Colors.deepOrange,
            )),
        themeMode: context.watch<ThemeProvider>().themeValue
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'blocFire Notes',
        home: const SplashPage(),
      ),
    );
  }
}

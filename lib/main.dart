import 'package:bloc_fire_notes/data/bloc/notes_bloc/note_bloc.dart';
import 'package:bloc_fire_notes/data/bloc/register_user/register_bloc.dart';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:bloc_fire_notes/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'repository/pages/splash_page.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => RegisterBloc(firebaseProvider: FirebaseProvider()),
    ),
    BlocProvider(
      create: (context) => NoteBloc(firebaseProvider: FirebaseProvider()),
    )
  ], child: const MyApp()));
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
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Merienda",
        ),
        debugShowCheckedModeBanner: false,
        title: 'blocFire Notes',
        home: const SplashPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './util/authenticationService.dart';
import './pages/loginPage.dart';
import './common/design.dart';
import './pages/profilePage.dart';
import './pages/rewardPage.dart';
import './pages/taskPage.dart';
import './ui/task_list_dialogue.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  TaskListDialog dialog = TaskListDialog();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: defaultTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => AuthenticationWrapper(),
            '/profile': (context) => ProfilePage(),
            '/rewards': (context) => RewardsPage(),
            '/tasks': (context) => TaskPage(),
          }),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return ProfilePage();
    }
    return LoginPage();
  }
}
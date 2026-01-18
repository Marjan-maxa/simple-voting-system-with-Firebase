import 'package:flutter/material.dart';
import 'package:project_firebase/main.dart';
import 'package:project_firebase/task_manager.dart';
import 'package:project_firebase/vote_screen.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'BD Voting',
      home: TaskManager(),
    );
  }
}

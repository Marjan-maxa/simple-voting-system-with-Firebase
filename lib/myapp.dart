import 'package:flutter/material.dart';
import 'package:project_firebase/vote_screen.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BD Voting',
      home: VoteScreen(),
    );
  }
}

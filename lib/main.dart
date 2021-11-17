import 'package:flutter/material.dart';
import 'package:users_posts_project/screens/all_users/all_users_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AllUserScreen(),
      ),
    );
  }
}

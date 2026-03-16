import 'package:flutter/material.dart';
import "package:adv_to_do_app8/user_login_screen.dart";
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserLoginScreen(),
        
    );
  }
}

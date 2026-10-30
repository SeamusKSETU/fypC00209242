import 'package:flutter/material.dart';
import 'login.dart';
import 'menu_pofficer.dart';
//import 'register.dart';
//import 'package:flutter/foundation.dart'; 
//import 'mac.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 247,247,247)),
      home: const Login(),// homescreen page
    );
  }
}

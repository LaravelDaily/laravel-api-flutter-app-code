import 'package:flutter/material.dart';
import 'package:laravel_api_flutter_app/Screens/Auth/Login.dart';
import 'package:laravel_api_flutter_app/Screens/Auth/Register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
      },
    );
  }
}

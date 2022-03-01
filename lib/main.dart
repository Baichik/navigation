import 'package:flutter/material.dart';
import 'package:navigation/clima/screens/loading_screen.dart';
import 'package:navigation/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Navigation';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Home(myAppTitle: appTitle),
    );
  }
}

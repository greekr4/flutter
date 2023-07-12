import 'package:flutter/material.dart';
import 'package:list_app/Screen/Screen_index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: 'List App',
    theme: ThemeData(primarySwatch: Colors.amber),
    home: ScreenIndex(),

  );
  }
}
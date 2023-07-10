import 'package:flutter/material.dart';
import 'package:news_app/Screen/news_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: NewsScreen(),
    );
  }
}

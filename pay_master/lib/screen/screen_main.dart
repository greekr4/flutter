import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인'),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          Padding(padding: EdgeInsets.all(5)),
          Icon(Icons.person),
          Padding(padding: EdgeInsets.all(5)),
        ],
      ),
      body: Center(child: Text('메인화면임')),
      drawer: Drawer(
        child: ListView(children: [Text('1')]),
      ),
    );
  }
}

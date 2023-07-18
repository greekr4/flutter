import 'package:flutter/material.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/game');
          },
          child: Text('zz'),
        ));
  }
}

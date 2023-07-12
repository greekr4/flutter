

import 'package:flutter/cupertino.dart';

class Scoreboard extends StatelessWidget{
  final int score;
  Scoreboard(this.score);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        '$score',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

}
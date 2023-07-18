import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends PositionComponent {
  ScoreBoard(this.score);

  int score;

  @override
  void render(Canvas canvas) {
    TextPainter painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    painter.text = TextSpan(
      text: '$score',
      style: TextStyle(
        fontSize: 36.0,
        color: Colors.amber,
      ),
    );

    painter.layout(minWidth: 400);
    painter.paint(canvas, new Offset(0, 60));
  }
}

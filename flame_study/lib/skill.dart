import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skill extends PositionComponent {
  Skill(this.score);

  int score;
  bool isButtonPressed = false;

  @override
  void render(Canvas canvas) {
    Paint buttonPaint = Paint();

    late ImageProvider imageProvider = (!isButtonPressed)
        ? AssetImage('assets/images/button.png')
        : AssetImage('assets/images/button2.png');

    imageProvider.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        final Rect destinationRect = Rect.fromLTWH(150, 600, 100, 50);
        canvas.drawImageRect(
          imageInfo.image,
          Rect.fromLTWH(0, 0, imageInfo.image.width.toDouble(),
              imageInfo.image.height.toDouble()),
          destinationRect,
          buttonPaint,
        );
      }),
    );
  }
}

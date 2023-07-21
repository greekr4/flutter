import 'dart:math';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:fly_game/boxstack.dart';
import 'package:fly_game/overlaytest.dart';
import 'package:fly_game/player.dart';
import 'package:fly_game/sky.dart';

class FlappyEmber extends FlameGame with TapDetector, HasCollisionDetection {
  late Timer? _timer;
  late Player player = Player();
  late Sky sky; // = Sky();
  late ScreenHitbox screenhitbox; // = ScreenHitbox();
  late double speed = 75;
  late final random = Random();
  late double _timeSinceBox = 0;
  late double _boxInterval = 1.3; //박스시간
  late bool gameonoff = true;
  late ScoreText scoretext = ScoreText(0);
  late overlay_gameover gameover_ray = overlay_gameover(0);
  List<BoxStack> boxStacks = [];

  @override
  Future<void>? onLoad() async {
    speed = 75;
    sky = Sky();
    screenhitbox = ScreenHitbox();
    add(sky);
    add(screenhitbox);
    add(player);
    final image = await Flame.images.load('coins.png');

    add(CoinImage(image));
    add(scoretext);

    return null;
  }

  void restart() {
    speed = 75;
    gameonoff = true;
    player.position = Vector2(50, 100);
    player.onLoad();
  }

  void gameover() async {
    for (BoxStack boxstack in boxStacks) {
      if (boxstack.isMounted) {
        remove(boxstack);
      }
    }
    boxStacks = [];
    gameonoff = false;
    player.die();

    await Future.delayed(Duration(seconds: 2));

    if (!gameover_ray.isMounted) {
      add(gameover_ray);
      gameover_ray.score = scoretext.score;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    speed += 5 * dt;
    _timeSinceBox += dt;

    if (_timeSinceBox > _boxInterval && gameonoff) {
      final boxStack = BoxStack(isBottom: Random().nextBool());
      boxStacks.add(boxStack);
      add(boxStack);
      // add(BoxStack(isBottom: random.nextBool()));
      _timeSinceBox = 0;
    }
  }

  @override
  void onTap() {
    super.onTap();
    if (gameonoff) {
      player.fly();
      scoretext.score++;
    } else if (!gameonoff && gameover_ray.isMounted) {
      gameonoff = true;
      remove(gameover_ray);
      scoretext.score = 0;
      speed = 75;
      player.reset();
    }
    // restart();
  }
}

class CoinImage extends PositionComponent {
  final ui.Image image;
  CoinImage(this.image) : super(priority: 1);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawImage(image, const Offset(20, 0), Paint());
  }
}

class ScoreText extends PositionComponent {
  int score;
  ScoreText(this.score) : super(priority: 1);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    TextPainter painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    painter.text = TextSpan(
        text: '$score',
        style: TextStyle(
          fontSize: 72.0,
          color: Colors.amber,
        ));

    painter.layout(minWidth: 400);
    painter.paint(canvas, const Offset(80, 80));
  }
}

class overlay_gameover extends PositionComponent {
  int score;
  overlay_gameover(this.score) : super(priority: 2);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(Rect.largest, Paint());
    TextPainter painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    painter.text = TextSpan(
        text: 'GAME OVER\nScore : $score',
        style: TextStyle(
          fontSize: 60.0,
          color: Colors.amber,
        ));

    painter.layout(minWidth: 400);
    painter.paint(canvas, const Offset(0, 300));
  }
}

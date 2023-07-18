import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:fly_game/box.dart';
import 'package:fly_game/boxstack.dart';
import 'package:fly_game/player.dart';
import 'package:fly_game/sky.dart';

class FlappyEmber extends FlameGame with TapDetector, HasCollisionDetection {
  late Player player = Player();
  late Sky sky; // = Sky();
  late ScreenHitbox screenhitbox; // = ScreenHitbox();
  late double speed = 75;
  late final random = Random();
  late double _timeSinceBox = 0;
  late double _boxInterval = 1.3; //박스시간
  late bool gameonoff = true;

  @override
  Future<void>? onLoad() async {
    speed = 75;
    sky = Sky();
    screenhitbox = ScreenHitbox();

    add(sky);
    add(screenhitbox);
    add(player);
    return null;
  }

  void restart() {
    speed = 75;
    gameonoff = true;
    player.position = Vector2(50, 100);
    player.onLoad();
  }

  void gameover() {
    player.reset();
    gameonoff = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    speed += 5 * dt;
    _timeSinceBox += dt;

    if (_timeSinceBox > _boxInterval && gameonoff) {
      add(BoxStack(isBottom: random.nextBool()));
      _timeSinceBox = 0;
    }
  }

  @override
  void onTap() {
    super.onTap();
    player.fly();
    // restart();
  }
}

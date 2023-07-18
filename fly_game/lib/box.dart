import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';
import 'package:flame/collisions.dart';

class Box extends SpriteComponent with CollisionCallbacks {
  static Vector2 initialSize = Vector2.all(50);
  Box({super.position}) : super(size: initialSize);

  @override
  Future<void>? onLoad() async {
    final image = await Flame.images.load('boxes/1.png');

    sprite = Sprite(image);
    add(CircleHitbox());
  }
}

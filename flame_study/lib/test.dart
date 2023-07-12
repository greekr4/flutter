

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class testzz extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
    sprite = await gameRef.loadSprite('test.jpg');
    // var origin = sprite!.originalSize; // <-- 실제사이즈
    // size = origin;
    final gameSize = gameRef.size;
    size = Vector2(gameSize.x, gameSize.y);
  }

}
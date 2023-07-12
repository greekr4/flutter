

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class AnimatedPlayer extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef {
  AnimatedPlayer(
      Vector2 position,
      Vector2 size,
      ) : super(
      position: position,
      size: size,
      anchor: Anchor.center,
  );

  @override
  Future<void>? onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'PlayerSheet.png',
      SpriteAnimationData.sequenced(
          texturePosition: Vector2(0,96),
          amount: 8,
          stepTime: 0.5,
          textureSize: Vector2(32,32),
      )
    );
    return super.onLoad();
  }

}
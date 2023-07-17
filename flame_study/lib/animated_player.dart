import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

double desize = 32;

class AnimatedPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  double option;

  AnimatedPlayer(Vector2 position, Vector2 size, this.option)
      : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void>? onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
        'PlayerSheet.png',
        SpriteAnimationData.sequenced(
          texturePosition: Vector2(0, desize * option),
          amount: 4,
          stepTime: 0.5,
          textureSize: Vector2(32, 32),
        ));
    return super.onLoad();
  }
}

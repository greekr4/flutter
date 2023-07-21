import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:fly_game/box.dart';
import 'package:fly_game/game.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<FlappyEmber> {
  Player() : super(size: Vector2(50, 50), position: Vector2(50, 100));

  @override
  Future<void>? onLoad() async {
    add(CircleHitbox()); //충돌위치

    final image = await Flame.images.load('ember.png');
    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
          amount: 4, stepTime: 0.10, textureSize: Vector2.all(128)),
    );
  }

  // @override
  // void onCollisionStart(_, __) {
  //   super.onCollisionStart(_, __);
  //   //충돌감지 이벤트
  //   print(_);
  //   print(__);
  //   gameRef.gameover();
  // }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    print(other is Box);
    if (other is Box) {
      //박스 감지

      gameRef.gameover();
    } else {
      //위아래 벽에 감지
      double jump = this.position.y < 0 ? 150 : -200;

      final effect = MoveByEffect(
          Vector2(0, jump),
          EffectController(
            duration: 0.5,
            curve: Curves.decelerate,
          ));
      add(effect);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 200 * dt;
    // print(position.x);
    // print(position.y);
  }

  void fly() {
    final effect = MoveByEffect(
        Vector2(0, -100),
        EffectController(
          duration: 0.5,
          curve: Curves.decelerate,
        ));
    add(effect);
  }

  void die() {
    final effect = MoveByEffect(
        Vector2(0, 200),
        EffectController(
          duration: 1,
          curve: Curves.decelerate,
        ));
    add(effect);
  }

  void reset() {}
}

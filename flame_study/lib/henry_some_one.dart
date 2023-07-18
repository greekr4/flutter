import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/src/components/core/component.dart';
import 'package:flame_study/animated_player.dart';
import 'package:flame_study/game_backgound.dart';
import 'package:flame_study/item.dart';
import 'package:flame_study/item_list_bottom_sheet.dart';
import 'package:flame_study/scoreboard.dart';
import 'package:flame_study/scoregame.dart';
import 'package:flame_study/skill.dart';
import 'package:flame_study/test.dart';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final ScoreBoard scoreboard = new ScoreBoard(0);
final Skill skillboard = new Skill(0);
int score = 0;
int plusscore = 0;
int tabvalue = 1;
double playerType = 3;
//플레이어 사이즈
final playerSize = Vector2(150, 100);
//플레이어 위치
final playerPosition = Vector2(200, 710);
final playerPosition2 = Vector2(110, 710);

late AnimatedPlayer player =
    AnimatedPlayer(playerPosition, playerSize, playerType);

late AnimatedPlayer player2 = AnimatedPlayer(playerPosition2, playerSize, 8);

class HenrySomeOneGame extends StatefulWidget {
  const HenrySomeOneGame({Key? key}) : super(key: key);

  @override
  State createState() => _HenrySomeOneGameState();
}

class _HenrySomeOneGameState extends State<HenrySomeOneGame> {
  List<int> list = [];

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 40,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      panel: Column(
        children: [
          ItemListBottomSheet(
            onTapItem: onTapItem,
          )
        ],
      ),
      body: GameWidget.controlled(
        gameFactory: () => MyStaticGame(list: list),
        loadingBuilder: (context) => const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, ex) => const Material(
          child: Center(
            child: Text('error'),
          ),
        ),
      ),
    );
  }

  void onTapItem(int index) {
    debugPrint(index.toString());
    if (list.contains(index)) return;

    if (scoreboard.score >= 10) {
      list.add(index);
      score = score - 10;
      plusscore++;
      tabvalue++;
      scoreboard.score = score;
      setState(() {});
    }
  }
}

class MyStaticGame extends FlameGame with HasCollisionDetection, TapCallbacks {
  Timer? _timer;

  List<int> list;

  MyStaticGame({required this.list});

  @override
  Color backgoundColor() => const Color(0x00000000);
  final GameBackGround _backGround = GameBackGround();

  @override
  Future onLoad() async {
    add(ScreenHitbox());
    await add(_backGround);

    //플레이어 타입

    //플레이어 input
    add(player);
    add(scoreboard);
    add(skillboard);

    _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => {
              score = score + plusscore,
              scoreboard.score = score,
              print(plusscore),
              print('score:  $score')
            });
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (list.isEmpty) return;
    Vector2 position = Vector2(list.last * 50, 100);
    add(Item(position, index: list.last));
  }

  @override
  void onTapUp(TapUpEvent event) {}

  @override
  void onTapDown(TapDownEvent event) {
    if (Rect.fromLTWH(150, 600, 100, 50).containsPoint(event.canvasPosition) &&
        !player2.isMounted) {
      skillboard.isButtonPressed = true;
      score = score + tabvalue;
      scoreboard.score = score;

      if (!player2.isMounted) {
        player.option = 5;
        player.onLoad();
        add(player2);

        _timer = Timer(Duration(seconds: 1), () {
          if (player2.isMounted) {
            player.option = 3;
            player.onLoad();
            remove(player2);
            skillboard.isButtonPressed = false;
          }
        });
      }
    }
  }
}

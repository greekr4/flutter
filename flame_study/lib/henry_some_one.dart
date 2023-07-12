import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/components/core/component.dart';
import 'package:flame_study/animated_player.dart';
import 'package:flame_study/game_backgound.dart';
import 'package:flame_study/item.dart';
import 'package:flame_study/item_list_bottom_sheet.dart';
import 'package:flame_study/scoreboard.dart';
import 'package:flame_study/scoregame.dart';
import 'package:flame_study/test.dart';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HenrySomeOneGame extends StatefulWidget {
  const HenrySomeOneGame({Key ? key}) : super(key:key);

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
    panel: Column(children: [
      ItemListBottomSheet(
        onTapItem: onTapItem,
      )
    ],),
    body: GameWidget.controlled(
        gameFactory: () => MyStaticGame(list : list),
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



  void onTapItem(int index){
    debugPrint(index.toString());
    if(list.contains(index)) return;
    list.add(index);
    setState(() {});
  }

}

class MyStaticGame extends FlameGame with HasCollisionDetection,TapCallbacks    {

  int score = 0;
  ScoreBoard scoreboard = new ScoreBoard(0);
  List<int> list;
  MyStaticGame({required this.list});



  @override
  Color backgoundColor() => const Color(0x00000000);
  final GameBackGround _backGround = GameBackGround();

  @override
  Future onLoad() async {





    add(ScreenHitbox());
    await add(_backGround);

    //플레이어 사이즈
    final playerSize = Vector2(150, 100);
    final playerSize2 = Vector2(150, 100);
    //플레이어 위치
    final playerPosition = Vector2(200, 710);
    final playerPosition2 = Vector2(200, 410);
    //플레이어 input
    add(AnimatedPlayer(playerPosition, playerSize));
    add(scoreboard);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(list.isEmpty) return;
    Vector2 position = Vector2(list.last *50, 100);
    add(Item(position,index:list.last));
  }

  @override
  void onTapUp(TapUpEvent event) {
    score++;
    scoreboard.score = score;
    print('z');



  }




  
}
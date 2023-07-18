import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:fly_game/Screen/indexScreen.dart';
import 'package:fly_game/game.dart';
import 'package:provider/provider.dart';

void main() {
  // final game = FlappyEmber();
  // runApp(GameWidget(game: game));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final game = FlappyEmber();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fly",
      routes: {
        '/index': (context) => IndexScreen(),
        '/game': (context) => GameWidget(game: game),
      },
      initialRoute: '/index',
    );

    // return MultiProvider(
    //   providers: [],
    //   child: MaterialApp(
    //     title: "fly",
    //     routes: {
    //       '/index': (context) => IndexScreen(),
    //     },
    //     initialRoute: '/index',
    //   ),
    // );
  }
}

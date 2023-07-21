import 'package:flame/game.dart';

import 'package:flutter/material.dart';
import 'package:fly_game/game.dart';

class GameOverlay extends StatefulWidget {
  final Game game;

  const GameOverlay(this.game, {super.key});

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => {},
                child: const Icon(
                  Icons.pause,
                  size: 30,
                ),
              ),
            ],
          ),
        ));
  }
}

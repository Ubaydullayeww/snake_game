import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/screen/game_screen.dart';
import 'package:snake_game/service/notifier/change_notifier.dart';
import 'package:snake_game/service/notifier/provider/provider.dart';
class SnakeApp extends StatelessWidget {
  const SnakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GameProvider(
      notifier: GameState(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SnakeGame(),
      ),
    );
  }
}
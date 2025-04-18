import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_game/screen/game_screen.dart';

import 'main.dart';

class SnakeApp extends StatelessWidget {
  const SnakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SnakeGame(),
    );
  }
}
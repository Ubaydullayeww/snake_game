import 'dart:math';

import 'package:flutter/material.dart';

import '../service/notifier/change_notifier.dart';
import '../service/notifier/provider/provider.dart';

class SnakeGame extends StatelessWidget {
  const SnakeGame({super.key});

  @override
  Widget build(BuildContext context) {
    final game = GameProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: game,
          builder: (context, _) {
            return Column(
              children: [
                const SizedBox(height: 10),
                Text('Score: ${game.score}', style: const TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 10),
                buildGrid(game),
                const SizedBox(height: 20),
                buildControls(game),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildGrid(GameState game) {
    return SizedBox(
      width: game.cols * 24,
      height: game.rows * 24,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: game.rows * game.cols,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: game.cols),
        itemBuilder: (context, index) {
          int x = index % game.cols;
          int y = index ~/ game.cols;
          final cell = Point(x, y);

          Color color;
          if (game.snake.first == cell) {
            color = Colors.greenAccent;
          } else if (game.snake.contains(cell)) {
            color = Colors.green;
          } else if (cell == game.food) {
            color = Colors.red;
          } else {
            color = Colors.grey[900]!;
          }

          return Container(
            margin: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        },
      ),
    );
  }

  Widget buildControls(GameState game) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () => game.changeDirection('up'),
              color: Colors.blue,
              iconSize: 36,
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () => game.changeDirection('down'),
              color: Colors.blue,
              iconSize: 36,
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => game.changeDirection('left'),
              color: Colors.blue,
              iconSize: 36,
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => game.changeDirection('right'),
              color: Colors.blue,
              iconSize: 36,
            ),
          ],
        ),
      ],
    );
  }
}


import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  final int rows = 24;
  final int cols = 24;
  final int squareSize = 24;
  List<Point<int>> snake = [const Point(10, 10)];
  Point<int> food = const Point(5, 5);
  String direction = 'up';
  int score = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (Timer t) => updateSnake());
  }

  void updateSnake() {
    setState(() {
      final head = snake.first;
      Point<int> newHead;
      switch (direction) {
        case 'up':
          newHead = Point(head.x, (head.y - 1 + rows) % rows);
          break;
        case 'down':
          newHead = Point(head.x, (head.y + 1) % rows);
          break;
        case 'left':
          newHead = Point((head.x - 1 + cols) % cols, head.y);
          break;
        case 'right':
          newHead = Point((head.x + 1) % cols, head.y);
          break;
        default:
          newHead = head;
      }

      snake.insert(0, newHead);

      if (newHead == food) {
        score++;
        spawnFood();
      } else {
        snake.removeLast();
      }
    });
  }

  void spawnFood() {
    final rand = Random();
    Point<int> newFood;
    do {
      newFood = Point(rand.nextInt(cols), rand.nextInt(rows));
    } while (snake.contains(newFood));
    food = newFood;
  }

  void changeDirection(String newDirection) {
    if ((direction == 'up' && newDirection == 'down') ||
        (direction == 'down' && newDirection == 'up') ||
        (direction == 'left' && newDirection == 'right') ||
        (direction == 'right' && newDirection == 'left')) {
      return;
    }
    direction = newDirection;
  }

  Widget buildGrid() {
    double gridWidth = cols * squareSize.toDouble();
    double gridHeight = rows * squareSize.toDouble();

    return SizedBox(
      width: gridWidth,
      height: gridHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rows * cols,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
        ),
        itemBuilder: (context, index) {
          int x = index % cols;
          int y = index ~/ cols;
          final cell = Point(x, y);

          Color color;
          if (snake.first == cell) {
            color = Colors.greenAccent;
          } else if (snake.contains(cell)) {
            color = Colors.green;
          } else if (cell == food) {
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text('Score: $score', style: const TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 10),
            buildGrid(),
            const SizedBox(height: 20),
            buildControls(),
          ],
        ),
      ),
    );
  }

  Widget buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () => changeDirection('up'),
              color: Colors.blue,
              iconSize: 36,
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () => changeDirection('down'),
              color: Colors.blue,
              iconSize: 36,
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => changeDirection('left'),
              color: Colors.blue,
              iconSize: 36,
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => changeDirection('right'),
              color: Colors.blue,
              iconSize: 36,
            ),
          ],
        ),
      ],
    );
  }
}

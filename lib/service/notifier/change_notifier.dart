import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  final int rows = 24;
  final int cols = 24;
  List<Point<int>> snake = [const Point(10, 10)];
  Point<int> food = const Point(5, 5);
  String direction = 'up';
  int score = 0;
  late Timer _timer;

  GameState() {
    _startGame();
  }

  void _startGame() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (_) => _updateSnake());
  }

  void _updateSnake() {
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
      _spawnFood();
    } else {
      snake.removeLast();
    }

    notifyListeners();
  }

  void _spawnFood() {
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

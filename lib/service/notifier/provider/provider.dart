import 'package:flutter/widgets.dart';
import '../change_notifier.dart';

class GameProvider extends InheritedNotifier<GameState> {
  const GameProvider({
    super.key,
    required GameState notifier,
    required Widget child,
  }) : super(notifier: notifier, child: child);

  static GameState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameProvider>()!.notifier!;
  }
}

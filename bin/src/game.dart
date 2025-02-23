// import 'package:win32/win32.dart';

import 'canvas.dart';
import 'level.dart';

/// Логика игры
class Game {
  /// Холст для отрисовки игры
  final Canvas canvas;

  /// Уровень игры ( можно использовать, например, для запуска разных по геймплею уровней / экранов )
  Level level;

  /// Индикатор паузы
  bool isPaused;

  /// Конструктор
  Game(this.canvas, this.level) : isPaused = false;

  void keyPress(int wParam) {}

  void timerUpdate() {
    level.timerUpdate();
  }

  void pauseGame() {}

  void repaint() {
    level.drawBoard();
  }
}

import 'dart:ffi';

import 'package:win32/win32.dart';

import 'canvas.dart';
import 'drawable.dart';

/// Абстрактный класс игрового уровня. Содержит базовую реализацию, которую можно переопределить
abstract class Level {
  // Отрисовываемые объекты
  /// TODO: определить класс рисуемых объектов
  List<Drawable> board = [];
  Canvas engine;

  // Параметры уровня
  int width;
  int height;
  int lastTime; // Когда в последний раз обновился
  late int currentTime; // текущее время дял обновления
  int score;

  ///TODO: разобраться с генерацией доски
  Level(this.engine, this.width, this.height)
      : lastTime = 0,
        score = 0;

  /// Функция обновления времени
  /// Обновления зависят от тикрейта игры
  void TimerUpdate();

  /// Прорисовка игральной доски
  void DrawBoard() {
    for (var element in board) {
      element.Draw(engine);
    }
  }

  /// Проверка на окончание игры
  bool get isGameOver;
}

import 'package:win32/win32.dart';

import 'canvas.dart';
import 'idrawable.dart';

/// Абстрактный класс игрового уровня. Содержит базовую реализацию, которую можно переопределить
abstract class Level {
  // Отрисовываемые объекты
  /// TODO: определить класс рисуемых объектов
  List<IDrawable> board = []; // Список для хранения отрисовываемых объектов
  Canvas engine; // Холст выступает отрисовщиком графики

  // Параметры уровня
  int width; // Ширина
  int height; // Высота
  int lastTime; // Когда в последний раз обновился (нужен для поддержки стабильного фреймрейта)
  late int currentTime; // текущее время дял обновления
  int score; // Прогресс игрока

  ///TODO: разобраться с генерацией доски
  Level(this.engine, this.width, this.height)
      : lastTime = 0,
        score = 0;

  /// Функция обновления времени
  /// Обновления зависят от тикрейта игры
  void timerUpdate();
  bool get isGameOver;
}

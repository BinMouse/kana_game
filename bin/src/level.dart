import 'canvas.dart';
import 'objects/widget.dart';

/// Абстрактный класс игрового уровня. Содержит базовую реализацию, которую можно переопределить
abstract class Level {
  // Отрисовываемые объекты
  List<Widget> board = [];
  Canvas engine;

  // Параметры уровня
  int width;
  int height;
  int lastTime; // Когда в последний раз обновился
  late int currentTime; // текущее время для обновления
  int speed;
  int score;

  ///TODO: разобраться с генерацией доски
  Level(this.engine, this.width, this.height)
      : lastTime = 0,
        score = 0,
        speed = 300;

  /// Функция обновления времени
  /// Обновления зависят от тикрейта игры
  void timerUpdate() {
    currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - lastTime < speed) return;
  }

  /// Прорисовка игральной доски
  void drawBoard() {
    for (var element in board) {
      element.draw(engine);
    }
  }

  /// Проверка на окончание игры
  bool get isGameOver;
}

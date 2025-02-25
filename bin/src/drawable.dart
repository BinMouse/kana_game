import 'point.dart';

import "canvas.dart";

/// Интерфейс отрисовываемых объектов.
///
/// Объект хранит ифнормацию о то, что нужно отрисовать и передаёт её холсту (отрисовщику)
abstract class Drawable {
  Point _origin;

  Drawable(Point position) : _origin = position;

  /// Отрисовка объекта при помощи холста
  void draw(Canvas engine);

  /// Получить позицию объекта
  Point get origin => _origin;

  /// Задать новую точку позиции
  set updatePositionPoint(Point newPosition) => _origin = newPosition;

  /// Задать новые координаты
  void moveTo(int X, int Y) {
    _origin.x = X;
    _origin.y = Y;
  }
}

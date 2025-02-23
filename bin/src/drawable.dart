import "canvas.dart";
import "point.dart";

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
  void set updatePositionPoint(Point newPosition) => _origin = newPosition;

  /// Задать новые координаты
  void moveTo(int X, int Y) {
    _origin.X = X;
    _origin.Y = Y;
  }
}

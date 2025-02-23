import "canvas.dart";
import "Point.dart";

/// Интерфейс отрисовываемых объектов.
///
/// Объект хранит ифнормацию о то, что нужно отрисовать и передаёт её холсту (отрисовщику)
abstract class Drawable {
  Point _origin;

  Drawable(Point position) : _origin = position;

  /// Отрисовка объекта при помощи холста
  void Draw(Canvas engine);

  /// Получить позицию объекта
  Point getPosition() => _origin;

  /// Задать новую точку позиции
  void SetNewPositionPoint(Point newPosition) => _origin = newPosition;

  /// Задать новые координаты
  void Move(int X, int Y) {
    _origin.X = X;
    _origin.Y = Y;
  }
}

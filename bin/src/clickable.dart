import "point.dart";

abstract class Clickable {
  /// Проверка на принадлежность точки
  bool isPointInside(Point point);

  /// Событие при нажатии
  void onClick();
}

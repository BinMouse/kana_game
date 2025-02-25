import '../point.dart';

// Миксин для внедрения функционала нажимаемого объекта
mixin MClickable {
  /// Проверка на принадлежность точки
  bool isPointInside(Point point);

  /// Событие при нажатии
  void onClick();
}

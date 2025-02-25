/// Класс, представляющий точку в двумерном пространстве.
class Point {
  /// Координата X.
  int x;

  /// Координата Y.
  int y;

  /// Конструктор по умолчанию.
  Point(this.x, this.y);

  /// Конструктор для создания точки в начале координат.
  Point.origin() : this(0, 0);

  /// Конструктор для создания точки из другой точки (копирование).
  Point.copy(Point other) : this(other.x, other.y);

  /// Перемещает точку на заданные значения по осям X и Y.
  void move(int deltaX, int deltaY) {
    x += deltaX;
    y += deltaY;
  }

  /// Возвращает расстояние до другой точки.
  int distanceTo(Point other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return (dx * dx + dy * dy);
  }

  /// Переопределение оператора == для сравнения точек.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Point && other.x == x && other.y == y;
  }  
}

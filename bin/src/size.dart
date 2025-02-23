class Size {
  int width;
  int height;

  /// Конструктор по умолчанию
  Size(this.width, this.height);

  /// Конструктор для создания квадратного размера
  Size.square(int dimension) : this(dimension, dimension);

  /// Конструктор для создания нулевого размера
  Size.zero() : this(0, 0);

  /// Получить площадь размера
  int get area => width * height;

  /// Проверить, является ли размер нулевым
  bool get isEmpty => width == 0 && height == 0;

  /// Проверить, является ли размер не нулевым
  bool get isNotEmpty => !isEmpty;

  /// Увеличить размер на заданные значения
  void inflate(int deltaWidth, int deltaHeight) {
    width += deltaWidth;
    height += deltaHeight;
  }

  /// Уменьшить размер на заданные значения
  void deflate(int deltaWidth, int deltaHeight) {
    width -= deltaWidth;
    height -= deltaHeight;
  }

  /// Сравнение 2-х размеров
  bool equals(Size other) {
    return width == other.width && height == other.height;
  }

  /// Переопределение оператора ==
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Size && other.width == width && other.height == height;
  }

  /// Переопределение hashCode
  @override
  int get hashCode => width.hashCode ^ height.hashCode;
}

import '../mixins/mclickable.dart';
import '../mixins/mdrawable.dart';
import '../point.dart';

/// Базовый абстрактный класс виджета.
/// 
/// Виджетом может являться любой элемент интерфейса.
abstract class Widget with  MClickable, MDrawable{
  Point _origin;

  Widget(this._origin);
  
  /// Получить позицию объекта
  Point get origin => _origin;

  /// Задать новую точку позиции
  set Position(Point newPosition) => _origin = newPosition;

  /// Задать новые координаты
  void moveTo(int X, int Y) {
    _origin.x = X;
    _origin.y = Y;
  }
}
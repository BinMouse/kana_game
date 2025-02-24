import '../canvas.dart';
import '../drawable.dart';
import '../mixins/clickable_mixin.dart';
import "../point.dart";
import '../enums.dart';
import 'package:win32/win32.dart';

class Button extends Drawable with ClickableMixin {
  int _width;
  int _height;
  String text;

  /// Конструктор
  Button(Point position, this.text, [int width = 120, int height = 50])
      : _width = width,
        _height = height,
        super(position);

  @override
  void draw(Canvas engine) {
    engine.drawRect(super.origin.x, super.origin.y, _width, _height, RGB(255, 255, 255));    
    engine.drawText(text, super.origin.x + (_width/2).toInt(), super.origin.y + 10, alignmentX: ALIGNMENT.CENTER, fontSize: 30);
  }

  @override
  bool isPointInside(Point point) {
    return point.x >= super.origin.x &&
        point.x <= super.origin.x + _width &&
        point.y >= super.origin.y &&
        point.y <= super.origin.y + _height;
  }
}

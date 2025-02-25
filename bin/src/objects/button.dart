import '../canvas.dart';
import '../drawable.dart';
import '../mixins/mClickable.dart';
import "../point.dart";
import '../enums.dart';
import 'package:win32/win32.dart';

/// Класс кнопки
class Button extends Drawable with MClickable {
  int width;
  int height;
  late int textColor;
  late int bgColor;
  String text;

  /// Конструктор
  Button(super.position, this.text, { this.width = 120, this.height = 50, int? bgColor, int? txtColor}) {
    textColor = txtColor ??= RGB(0, 0, 0);
    this.bgColor = bgColor ??= RGB(255, 255, 255);
  }

  // отрисовка объекта
  @override
  void draw(Canvas engine) {
    engine.drawRect(
        super.origin.x, super.origin.y, width, height, RGB(255, 255, 255));
    engine.drawText(text, super.origin.x + (width / 2).toInt(),
        super.origin.y + (height / 2).toInt(),
        fontSize: 35,
        color: RGB(0, 0, 0),
        alignmentX: ALIGNMENT.CENTER,
        alignmentY: ALIGNMENT.CENTER);
  }

  // Проверкана принадлежность точки к области кнопки
  @override
  bool isPointInside(Point point) {
    return point.x >= super.origin.x &&
        point.x <= super.origin.x + width &&
        point.y >= super.origin.y &&
        point.y <= super.origin.y + height;
  }

  // Событие нажатия
  @override
  void onClick() {
    // TODO: implement onClick
  }
}

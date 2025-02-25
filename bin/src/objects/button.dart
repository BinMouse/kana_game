import '../canvas.dart';
import "../point.dart";
import '../enums.dart';
import 'widget.dart';
import 'package:win32/win32.dart';


/// Класс кнопки
class Button extends Widget {
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

    // Отрисовка границы
    engine.drawRect(origin.x, origin.y, width, height, RGB(255, 255, 255));
    
    // Текст кнопки
    engine.drawText(text, 
        origin.x + (width / 2).toInt(),
        origin.y + (height / 2).toInt(),
        fontSize: 35,
        color: RGB(0, 0, 0),
        alignmentX: ALIGNMENT.CENTER,
        alignmentY: ALIGNMENT.CENTER);
  }

  // Проверкана принадлежность точки к области кнопки
  @override
  bool isPointInside(Point point) {
    return point.x >= origin.x &&
        point.x <= origin.x + width &&
        point.y >= origin.y &&
        point.y <= origin.y + height;
  }

  // Событие нажатия
  @override
  void onClick() {
    // TODO: implement onClick
  }
}

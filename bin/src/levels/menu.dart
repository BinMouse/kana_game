import '../level.dart';
import '../objects/button.dart';
import '../point.dart';

class Menu extends Level {
  Menu(super.engine, super.width, super.height) {
    // пробы
    super.board.add(Button(Point(0, 0), "A"));
    super.board.add(Button(Point(width - 120, height - 50), "i"));
    super.board.add(Button(Point(240, 0), "AAA"));
  }

  @override
  bool get isGameOver => false;

  @override
  void timerUpdate() {
    return;
  }
}

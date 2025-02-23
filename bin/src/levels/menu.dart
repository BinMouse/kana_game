import '../level.dart';
import '../objects/button.dart';
import '../point.dart';

class Menu extends Level {
  Menu(super.engine, super.width, super.height) {
    // пробы
    super.board.add(Button(Point(0, 0), "Test menu"));
    super.board.add(Button(Point(width - 120, height - 50), "Button"));
    super.board.add(Button(Point(240, 0), "Button"));
  }

  @override
  bool get isGameOver => false;

  @override
  void timerUpdate() {
    return;
  }
}

import '../level.dart';
import '../objects/button.dart';
import '../point.dart';

class Menu extends Level {
  Menu(super.engine, super.width, super.height) {
    // пробы
    int botHeig = 70;
    int botWidth = 160;
    super.board.add(Button(
        Point((width / 2).toInt() - botWidth - 20, (height / 2).toInt() - (botWidth/2).toInt()), "Start", width: botWidth, height: botHeig));
    super.board.add(Button(
        Point((width / 2).toInt() + 20, (height / 2).toInt() - (botWidth/2).toInt()), "Exit", width: botWidth, height: botHeig));
  }
  @override
  bool get isGameOver => false;

  @override
  void timerUpdate() {
    return;
  }
}

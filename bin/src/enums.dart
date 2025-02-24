import 'package:win32/win32.dart';

/// Константы цвета
extension type const APP_COLORS(int _) implements int {
  static final PRIMARY_GAME_COLOR = RGB(255, 255, 255);
  static final SECONDARY_GAME_COLOR = RGB(150, 150, 150);
  static final BUTTON_TEXT_COLOR = RGB(0, 0, 0);
  static final BACKGROUND_COLOR = RGB(0, 0, 0);
}

/// Константы выравнивания
extension type const ALIGNMENT(int _) implements int {
  static const LEFT = 0;
  static const TOP = 0;
  static const CENTER = 1;
  static const RIGHT = 2;
  static const BOTTOM = 2;
}

///Холст отрисовки
class Canvas {
  /// Перехватчик DC
  final int hdc;

  /// Перехвадчик сообщений окна
  final int hwnd;

  /// Высота холста
  final int height;

  // Ширина холста
  final int width;

  Canvas({
    required this.hdc,
    required this.hwnd,
    required this.width,
    required this.height,
  });
}

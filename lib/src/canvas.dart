///Холст отрисовки
class Canvas {
  /// Перехвадчик сообщений окна
  final int hwnd;

  /// Высота холста
  final int height;

  // Ширина холста
  final int width;

  Canvas({required this.width, required this.height, required this.hwnd});
}

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

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

  /// Прямоугольник для рисования. Он будет существовать в течение всего времени работы приложения,
  /// а память освободится при завершении приложения.
  final Pointer<RECT> rect = calloc<RECT>();

  /// Конструктор
  Canvas(
    this.hdc,
    this.hwnd,
    this.width,
    this.height,
  ) {
    GetClientRect(hwnd, rect);

    SaveDC(hdc);

    // Установка системы координат
    SetMapMode(hdc, HDC_MAP_MODE.MM_ISOTROPIC);
    SetWindowExtEx(hdc, width, height, nullptr);
    SetViewportExtEx(hdc, width, height, nullptr);
    SetViewportOrgEx(hdc, 0, 0, nullptr);

    // Set default colors
    SetTextColor(hdc, RGB(0, 0, 0));
    SetBkColor(hdc, RGB(0, 0, 70));
    SetBkMode(hdc, BACKGROUND_MODE.TRANSPARENT);
  }

  /// Отрисовка прямоугольника
  void drawRect(int x, int y, int width, int height, int color) {
    final hBrush = CreateSolidBrush(color);
    Rectangle(hdc, x, y, x + width, y + height);
    DeleteObject(hBrush);
  }

  void drawText(String text, int x, int y) {
    final lpString = text.toNativeUtf16();
    TextOut(hdc, x, y, lpString, text.length);
    free(lpString);
  }
}

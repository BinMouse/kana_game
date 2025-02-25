import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'enums.dart';

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
    SetTextColor(hdc, RGB(255, 255, 255));
    SetBkColor(hdc, RGB(0, 0, 70));
    SetBkMode(hdc, BACKGROUND_MODE.TRANSPARENT);
  }

  /// Отрисовка прямоугольника
  void drawRect(int x, int y, int width, int height, int color) {
    final hBrush = CreateSolidBrush(color);
    Rectangle(hdc, x, y, x + width, y + height);
    DeleteObject(hBrush);
  }

  /// Функция отрисоки текста.
  ///
  /// [fontName] - отвечает за шрифт.
  /// Шрифт по умолчанию: "Pixel Operator Bold".
  ///
  /// [fontSize] - отвечает за размер (высоту) шрифта.
  /// Размер по умолчанию: .
  ///
  /// [alignmentX] - выравнивание по горизонтали.
  /// По умолчанию: LEFT.
  /// 
  /// [alignmentY] - выравнивание по вертикали.
  /// По умолчанию: LEFT.
  void drawText(String text, int x, int y, {int? color, int? fontSize, String? fontName, int? alignmentX = ALIGNMENT.LEFT, int? alignmentY = ALIGNMENT.LEFT}) {
    
    // Настройка шрифта
    SetTextColor(hdc, color??=APP_COLORS.PRIMARY_GAME_COLOR);
    Pointer<LOGFONT> pfont = calloc<LOGFONT>();
    pfont.ref.lfHeight = fontSize ??= 24;
    pfont.ref.lfFaceName = fontName ??= "Joystix Monospace";
    pfont.ref.lfQuality = FONT_QUALITY.NONANTIALIASED_QUALITY;
    int nFont = CreateFontIndirect(pfont);
    SelectObject(hdc, nFont);

    switch (alignmentY) {
      case (ALIGNMENT.CENTER):
        y = y - (fontSize / 2).toInt();
        break;
      case (ALIGNMENT.RIGHT):
        y = y - fontSize;
        break;
    }

    switch (alignmentX) {
      case (ALIGNMENT.CENTER):
        x = x - (getTextLengthInPixels(text) / 2).toInt();
        break;
      case (ALIGNMENT.RIGHT):
        x = x - getTextLengthInPixels(text);
        break;
    }

    final lpString = text.toNativeUtf16();
    TextOut(hdc, x, y, lpString, text.length);

    // Очистка паяти и сброс настроек
    SetTextColor(hdc, RGB(255, 255, 255));
    DeleteObject(nFont);
    free(lpString);
    free(pfont);
  }

  int getTextLengthInPixels(String text) {
    int mw = 0;
    Pointer<TEXTMETRIC> lptm = calloc<TEXTMETRIC>();
    GetTextMetrics(hdc, lptm);
    mw = lptm.ref.tmMaxCharWidth;
    return text.runes.length * mw;
  }
}

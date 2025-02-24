// ignore_for_file: constant_identifier_names

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'src/canvas.dart';
import 'src/game.dart';
import 'src/levels/menu.dart';
import 'src/styles/colors.dart';

//
// ========================= Глобальные переменные =============================
//
const SCREEN_WIDTH = 1600; // Ширина окна в пикселях
const SCREEN_HEIGHT = 900; // Высота окна в пикселях
const GAME_SPEED = 33; // Тикрейт игры (обновление каждые 33 мс)
const TIMER_ID = 1; // Идентификатор глобального таймера
late Game game; // объект игры
late Canvas canvas; // объект-отрисовщик

// Получаем перехватчик для текущего процесса
final hInstance = GetModuleHandle(nullptr);

//
// ============================ Старт программы ================================
//

void main() {
  final szAppName = 'Kana Game'.toNativeUtf16(); // Имя окна (нужно для WinAPI)

  // Обработчик оконных сообщений создаёт объект, который можно передавать в WinAPI как функцию.
  final lpfnWndProc = NativeCallable<WNDPROC>.isolateLocal(
    mainWindowProc,
    exceptionalReturn: 0,
  );

  // Описание класса окна
  final wc =
      calloc<WNDCLASS>() // WNDCLASS — структура, описывающая параметры окна
        ..ref.style = WNDCLASS_STYLES.CS_HREDRAW |
            WNDCLASS_STYLES.CS_VREDRAW |
            WNDCLASS_STYLES.CS_OWNDC
        ..ref.lpfnWndProc = lpfnWndProc.nativeFunction
        ..ref.hInstance = hInstance // Передаём наш перехватчик
        ..ref.hIcon = LoadIcon(hInstance, IDI_APPLICATION) // Иконка
        ..ref.hCursor = LoadCursor(NULL, IDC_ARROW) // Курсор
        ..ref.hbrBackground = GET_STOCK_OBJECT_FLAGS.GRAY_BRUSH // Цвет фона
        ..ref.lpszClassName = szAppName; // Имя окна
  RegisterClass(wc); // Регистрация класса окна

  // Создание окна
  final hWnd = CreateWindowEx(
    0, // опциональные стили окна
    szAppName, // Класс окна
    szAppName, // Текст окна
    WINDOW_STYLE.WS_MINIMIZEBOX |
        WINDOW_STYLE.WS_SYSMENU |
        WINDOW_STYLE.WS_MAXIMIZEBOX |
        WINDOW_STYLE.WS_CAPTION, // Стиль окна
    0, 0, // Позиция окна
    SCREEN_WIDTH,
    SCREEN_HEIGHT,
    NULL, NULL,
    hInstance, // Дескриптор
    nullptr,
  );

  // проверяем, создалось ли окно. Если нет - отлавливаем ошибку
  if (hWnd == 0) {
    stderr.writeln('CreateWindowEx завершено с ошибкой: ${GetLastError()}');
    exit(-1);
  }

  ShowWindow(hWnd, SHOW_WINDOW_CMD.SW_SHOWNORMAL);
  UpdateWindow(hWnd);

  // Запуск цикла обработки сообщений
  final msg = calloc<MSG>();
  while (GetMessage(msg, NULL, 0, 0) != 0) {
    TranslateMessage(msg);
    DispatchMessage(msg);
  }

  lpfnWndProc.close();
  free(szAppName);
}

/// Функция обработки сообщений
int mainWindowProc(int hwnd, int uMsg, int wParam, int lParam) {
  int hdc;
  final ps = calloc<PAINTSTRUCT>();

  switch (uMsg) {
    case WM_CREATE:
      hdc = GetDC(hwnd);
      final clientArea = calloc<RECT>();
      GetClientRect(hwnd, clientArea);
      int width = clientArea.ref.right - clientArea.ref.left;

      int height = clientArea.ref.bottom - clientArea.ref.top;

      canvas = Canvas(hdc, hwnd, width, height);
      game = Game(canvas, Menu(canvas, width, height));
      SetTimer(hwnd, TIMER_ID, GAME_SPEED, nullptr);

    case WM_PAINT:
      hdc = BeginPaint(hwnd, ps);
      game.repaint();
      EndPaint(hwnd, ps);

    case WM_DESTROY:
      KillTimer(hwnd, TIMER_ID);
      PostQuitMessage(0);
  }
  return DefWindowProc(hwnd, uMsg, wParam, lParam);
}

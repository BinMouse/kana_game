// ignore_for_file: constant_identifier_names

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

// import './src/canvas.dart';

// глобальные переменные
// const PX_PER_BLOCK = 25; // Размер одной клетки в пикселях
const SCREEN_WIDTH = 1600; // Ширина окна в пикселях
const SCREEN_HEIGHT = 800; // Высота окна в пикселях
const GAME_SPEED = 33; // Тикрейт игры (обновление каждые 33 мс)
const TIMER_ID = 1; // Идентификатор таймера

final hInstance = GetModuleHandle(
    nullptr); // Получаем дескриптор текущего процесса. Он нужен операционной системе для хранения информации о процессе

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
        ..ref.lpfnWndProc =
            lpfnWndProc.nativeFunction // lpfnWndProc - обработчик событий
        ..ref.hInstance = hInstance // Передаём наш дескриптор.
        ..ref.hIcon = LoadIcon(NULL, IDI_APPLICATION) // Иконка
        ..ref.hCursor = LoadCursor(NULL, IDC_ARROW) // Курсор
        ..ref.hbrBackground = GET_STOCK_OBJECT_FLAGS.GRAY_BRUSH // Цвет фона
        ..ref.lpszClassName = szAppName; // Имя окна
  RegisterClass(wc); // Регистрация класса окна

  // Создание окна
  final hWnd = CreateWindowEx(
    0, // опциональные стили окна
    szAppName, // Класс окна
    szAppName, // Текст окна
    WINDOW_STYLE.WS_MINIMIZEBOX | WINDOW_STYLE.WS_SYSMENU, // Стиль окна
    CW_USEDEFAULT, CW_USEDEFAULT, // позиция окна
    SCREEN_WIDTH, SCREEN_HEIGHT, // размеры окна
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
  switch (uMsg) {
    case WM_DESTROY:
      PostQuitMessage(0);
      return 0;
  }
  return DefWindowProc(hwnd, uMsg, wParam, lParam);
}

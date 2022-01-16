import 'package:flutter/material.dart';

const defaultColor = Colors.teal;
class Palette {
  static const MaterialColor defaultColor = const MaterialColor(
    0xff00919F, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff00838f),//10%
      100: const Color(0xff00838f),//20%
      200: const Color(0xff00666f),//30%
      300: const Color(0xff00575f),//40%
      400: const Color(0xff004950),//50%
      500: const Color(0xff003a40),//60%
      600: const Color(0xff002b30),//70%
      700: const Color(0xff001d20),//80%
      800: const Color(0xff000e10),//90%
      900: const Color(0xff000000),//100%
    },
  );
}
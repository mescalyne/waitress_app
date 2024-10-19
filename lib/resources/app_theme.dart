import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  AutoTheme get theme {
    var brightness = MediaQuery.of(this).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    if (isDarkMode) {
      return AutoTheme.darkTheme;
    } else {
      return AutoTheme.lightTheme;
    }
  }
}

@immutable
class AutoTheme extends ThemeExtension<AutoTheme> {
  const AutoTheme({
    required this.background1,
    required this.background2,
    required this.background3,
    required this.background4,
    required this.container1,
    required this.container2,
    required this.container3,
    required this.container4,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.accentColor1,
    required this.accentColor2,
  
  });

  final Color background1;
  final Color background2;
  final Color background3;
  final Color background4;
  final Color container1;
  final Color container2;
  final Color container3;
  final Color container4;

  final Color text1;
  final Color text2;
  final Color text3;

  final Color accentColor1;
  final Color accentColor2;

  static const lightTheme = darkTheme;
  static const darkTheme = AutoTheme(
    background1: Color(0xFF161616),
    background2: Color(0xFF201C19),
    background3: Color.fromARGB(255, 43, 43, 43),
    background4: Color(0xFF303b3e),
    container1: Color(0xFFECECEC),
    container2: Color(0xFFB3661F),
    container3: Color(0xFFEF8829),
    container4: Color(0xFF84BD94),
    text1: Color(0xFFFFFFFF),
    text2: Color(0xff000000),
    text3: Color.fromRGBO(219, 219, 219, 0.7),
    accentColor1: Color(0xFFD15A40),
    accentColor2: Color(0xFFD19155),
  );

  @override
  ThemeExtension<AutoTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AutoTheme> lerp(ThemeExtension<AutoTheme>? other, double t) {
    throw UnimplementedError();
  }
}

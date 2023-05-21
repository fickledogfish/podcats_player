import 'package:flutter/material.dart';
import 'package:podcats_player/view/theme/theme.dart';

final defaultTheme = AppTheme(
  light: _lightTheme,
  dark: _darkTheme,
);

final _lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.grey[300],
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: Colors.black87),
    titleSmall: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  colorScheme: ColorScheme.light(
    background: Colors.grey[300]!,
    error: Colors.red,
    errorContainer: Colors.red[100],
  ),
);

final _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: Colors.white60),
    titleSmall: TextStyle(color: Colors.white54, fontWeight: FontWeight.normal),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.grey,
    secondary: Colors.amber,
    background: Colors.black,
    error: Colors.red[900]!,
    errorContainer: Colors.red[300],
  ),
);

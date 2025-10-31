import 'package:flutter/material.dart';

abstract class CustomTheme {
  ThemeData get themeData;

  // Core
  ColorScheme get colorScheme;
  TextTheme get textTheme;

  // Components
  AppBarTheme get appBarTheme;
  BottomNavigationBarThemeData get bottomNavigationBarTheme;
  FloatingActionButtonThemeData get floatingActionButtonThemeData;
  CardTheme get cardTheme;
  DialogTheme get dialogTheme;
  DividerThemeData get dividerTheme;
  DropdownMenuThemeData get dropdownMenuTheme;
  ElevatedButtonThemeData get elevatedButtonTheme;
  FilledButtonThemeData get filledButtonTheme;
  IconThemeData get iconTheme;
  InputDecorationTheme get inputDecorationTheme;
  ListTileThemeData get listTileTheme;
  OutlinedButtonThemeData get outlinedButtonTheme;
  SearchBarThemeData get searchBarTheme;
  SnackBarThemeData get snackBarTheme;
}

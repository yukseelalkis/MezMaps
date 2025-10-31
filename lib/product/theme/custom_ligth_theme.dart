import 'package:flutter/material.dart';
import 'package:mezmaps/product/theme/custom_theme.dart';
import 'package:mezmaps/product/theme/theme.dart'; // CustomColorTheme burada

class CustomLightTheme implements CustomTheme {
  // ---- Color Scheme (tek kaynak)
  ColorScheme get _scheme => CustomColorTheme.lightScheme();

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    elevation: 0,
    backgroundColor: _scheme.primary,
    foregroundColor: _scheme.onPrimary,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: _scheme.onPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    iconTheme: IconThemeData(color: _scheme.onSurface),
  );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: _scheme.surface,
        selectedItemColor: _scheme.primary,
        unselectedItemColor: _scheme.onSurface.withValues(),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      );

  @override
  CardTheme get cardTheme => CardTheme(
    color: _scheme.surfaceContainer,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.all(12),
  );

  @override
  ColorScheme get colorScheme => _scheme;

  @override
  DialogTheme get dialogTheme => DialogTheme(
    backgroundColor: _scheme.surfaceContainerHigh,
    titleTextStyle: TextStyle(
      color: _scheme.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
    contentTextStyle: TextStyle(color: _scheme.onSurface, fontSize: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  @override
  DividerThemeData get dividerTheme =>
      DividerThemeData(color: _scheme.outlineVariant, thickness: 1, space: 0);

  @override
  DropdownMenuThemeData get dropdownMenuTheme => DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(_scheme.surfaceContainer),
      elevation: const WidgetStatePropertyAll(2),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    textStyle: TextStyle(color: _scheme.onSurface),
    inputDecorationTheme: inputDecorationTheme,
  );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      backgroundColor: WidgetStatePropertyAll(_scheme.primary),
      foregroundColor: WidgetStatePropertyAll(_scheme.onPrimary),
      overlayColor: WidgetStatePropertyAll(_scheme.onPrimary.withValues()),
    ),
  );

  @override
  FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      backgroundColor: WidgetStatePropertyAll(_scheme.primaryContainer),
      foregroundColor: WidgetStatePropertyAll(_scheme.onPrimaryContainer),
    ),
  );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      FloatingActionButtonThemeData(
        backgroundColor: _scheme.primary,
        foregroundColor: _scheme.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );

  @override
  IconThemeData get iconTheme => IconThemeData(color: _scheme.onSurface);

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: _scheme.surfaceContainerHigh,
    hintStyle: TextStyle(color: _scheme.onSurface.withValues()),
    labelStyle: TextStyle(color: _scheme.onSurface),
    helperStyle: TextStyle(color: _scheme.onSurfaceVariant),
    errorStyle: const TextStyle(fontWeight: FontWeight.w600),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: _scheme.outlineVariant),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: _scheme.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: _scheme.primary, width: 1.2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: _scheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: _scheme.error, width: 1.2),
    ),
  );

  @override
  ListTileThemeData get listTileTheme => ListTileThemeData(
    iconColor: _scheme.onSurface,
    textColor: _scheme.onSurface,
    tileColor: _scheme.surfaceContainer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      side: WidgetStatePropertyAll(BorderSide(color: _scheme.primary)),
      foregroundColor: WidgetStatePropertyAll(_scheme.primary),
      overlayColor: WidgetStatePropertyAll(_scheme.primary.withValues()),
    ),
  );

  @override
  SearchBarThemeData get searchBarTheme => SearchBarThemeData(
    backgroundColor: WidgetStatePropertyAll(_scheme.surfaceContainerHigh),
    elevation: const WidgetStatePropertyAll(0),
    hintStyle: WidgetStatePropertyAll(
      TextStyle(color: _scheme.onSurface.withValues()),
    ),
    textStyle: WidgetStatePropertyAll(TextStyle(color: _scheme.onSurface)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    backgroundColor: _scheme.inverseSurface,
    contentTextStyle: TextStyle(color: _scheme.onSurface),
    actionTextColor: _scheme.primary,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  @override
  TextTheme get textTheme => const TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
  );

  // ---- THEMEDATA (tek yerden derli toplu)
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _scheme,
    scaffoldBackgroundColor: _scheme.surface,
    canvasColor: _scheme.surface,

    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    dividerTheme: dividerTheme,
    dropdownMenuTheme: dropdownMenuTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    filledButtonTheme: filledButtonTheme,
    floatingActionButtonTheme: floatingActionButtonThemeData,
    iconTheme: iconTheme,
    inputDecorationTheme: inputDecorationTheme,
    listTileTheme: listTileTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    searchBarTheme: searchBarTheme,
    snackBarTheme: snackBarTheme,

    textTheme: textTheme.apply(
      bodyColor: _scheme.onSurface,
      displayColor: _scheme.onSurface,
    ),
  );
}

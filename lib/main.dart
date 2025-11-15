import 'package:flutter/material.dart';
import 'package:mezmaps/feature/deaths/view/deaths_view.dart';
import 'package:mezmaps/feature/grave_search/view/grave_search_view.dart';
import 'package:mezmaps/product/theme/custom_dark_theme.dart';
import 'package:mezmaps/product/theme/custom_ligth_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: CustomDarkTheme().themeData,
      theme: CustomLightTheme().themeData,
      themeMode: ThemeMode.light,
      home: DeathsView(),
    );
  }
}

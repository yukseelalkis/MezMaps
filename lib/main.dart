import 'package:flutter/material.dart';
import 'package:mezmaps/feature/cemeteries/view/cemeteries_view.dart';
import 'package:mezmaps/feature/grave_location/view/grave_location_view.dart';
import 'package:mezmaps/feature/home/view/home_view.dart';
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
      darkTheme: CustomDarkTheme().themeData,
      theme: CustomLightTheme().themeData,
      themeMode: ThemeMode.light,
      home: GraveSearchPage(),
    );
  }
}

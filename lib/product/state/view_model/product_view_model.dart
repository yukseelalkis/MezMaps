import 'package:flutter/material.dart';
import 'package:mezmaps/product/state/base/base_cubit.dart';
import 'package:mezmaps/product/state/view_model/product_state.dart';

/// burada tema gibi global degisiklikler vs yonetmek icin kullanmayi amacliyoruz
final class ProductViewModel extends BaseCubit<ProductState> {
  ProductViewModel() : super(ProductState());

  /// Toggle theme mode between light and dark automatically
  void changeThemeMode() {
    final current = state.themeMode;
    final newMode = current == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(state.copyWith(themeMode: newMode));
  }
}

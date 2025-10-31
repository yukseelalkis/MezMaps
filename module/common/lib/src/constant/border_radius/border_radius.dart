import 'package:flutter/material.dart';

@immutable
/// This is border radius manager
final class BorderRadiusManager {
  /// [normalBorderRadius] is border radius for normal as `10`
  static final BorderRadius normalBorderRadius = BorderRadius.circular(10);

  /// [moreBorderRadius] is border radius for button as `20`
  static final BorderRadius moreBorderRadius = BorderRadius.circular(20);

  /// [extraMoreBorderRadius] is border radius for card as `30`
  static final BorderRadius extraMoreBorderRadius = BorderRadius.circular(30);

  /// [loginBorderRadius] is border radius for card as `30`
  static final BorderRadius loginBorderRadius = BorderRadius.circular(45);
}

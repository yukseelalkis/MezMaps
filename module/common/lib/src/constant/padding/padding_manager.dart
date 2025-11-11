import 'package:flutter/material.dart';

/// A utility class for managing responsive paddings based on screen size.
@immutable
final class PaddingManager {
  /// Returns a small padding using 1% of screen height.
  static EdgeInsets lessPaddingAll(BuildContext context) =>
      EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.01);

  /// Returns a normal padding using 1.5% of screen height.
  static EdgeInsets normalPaddingAll(BuildContext context) =>
      EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.015);

  /// Returns a larger padding using 3% of screen height.
  static EdgeInsets morePaddingAll(BuildContext context) =>
      EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.03);

  /// Returns a horizontal symmetric padding using 3% of screen width.
  static EdgeInsets normalPaddingSymmetricHorizontal(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.03);

  /// Returns a horizontal symmetric padding using 6% of screen width.
  static EdgeInsets morePaddingSymmetricHorizontal(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.06);

  /// Returns a vertical symmetric padding using 1.5% of screen height.
  static EdgeInsets normalPaddingSymmetricVertical(BuildContext context) =>
      EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height * 0.015);

  /// Returns a vertical symmetric padding using 3% of screen height.
  static EdgeInsets morePaddingSymmetricVertical(BuildContext context) =>
      EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height * 0.03);

  /// Returns only the normal padding value as double (1.5% of screen height).
  static double normalPadding(BuildContext context) =>
      MediaQuery.sizeOf(context).height * 0.015;

  /// Returns only the large padding value as double (3% of screen height).
  static double morePadding(BuildContext context) =>
      MediaQuery.sizeOf(context).height * 0.03;

  /// Returns padding optimized for button content.
  /// (4% horizontal, 1.2% vertical)
  static EdgeInsets buttonContentPadding(BuildContext context) =>
      EdgeInsets.only(right: MediaQuery.sizeOf(context).width * 0.06);

  /// Returns a padding optimized for list items or small sections.
  /// (Uses approx. 4% of width for horizontal, 1% of height for vertical)
  static EdgeInsets listItemPadding(BuildContext context) =>
      EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.04,
        vertical: MediaQuery.sizeOf(context).height * 0.01,
      );

  static EdgeInsets responsiveLTRB(BuildContext context) => EdgeInsets.fromLTRB(
    MediaQuery.sizeOf(context).width * 0.04,
    MediaQuery.sizeOf(context).height * 0.015,
    MediaQuery.sizeOf(context).width * 0.04,
    MediaQuery.sizeOf(context).height * 0.015,
  );
}

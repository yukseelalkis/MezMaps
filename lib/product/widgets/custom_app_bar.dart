import 'package:flutter/material.dart';

final class CustomAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbar({required this.text, required this.widget});
  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Text(text), const SizedBox(width: 8), widget],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

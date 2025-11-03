import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  // Geri tuşu olsun istiyorsan bunu kullan:
  Future<T?> pushTo<T>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // Mevcut sayfayı değiştirir: Geri oku yok eder.
  Future<T?> replaceWith<T, TO>(Widget page, {TO? result}) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  // Animasyonsuz push (istersen):
  Future<T?> pushNoAnim<T>(Widget page) {
    return Navigator.push<T>(
      this,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  // Animasyonsuz replace (geri oku yine olmaz):
  Future<T?> replaceNoAnim<T, TO>(Widget page, {TO? result}) {
    return Navigator.pushReplacement<T, TO>(
      this,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      result: result,
    );
  }

  // Güvenli geri: pop mümkün değilse hiçbir şey yapma (veya burada Home’a gitmeyi seçebilirsin)
  void safePop<T extends Object?>([T? result]) {
    if (Navigator.canPop(this)) {
      Navigator.pop<T>(this, result);
    } else {
      // İstersen burada Home’a git:
      // replaceNoAnim(const HomeView());
    }
  }
}

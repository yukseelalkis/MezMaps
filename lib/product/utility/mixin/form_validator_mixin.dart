import 'package:flutter/material.dart';

/// Genel form doğrulama yardımcıları.
/// Tüm view’lerde ortak kullanılabilir.
mixin FormValidatorMixin<T extends StatefulWidget> on State<T> {
  /// Boşsa hata vermez, min karakter kontrolü.
  String? minLenOrNull(String? value, {int min = 2, String? fieldName}) {
    if (value == null || value.trim().isEmpty) return null;
    return value.trim().length < min
        ? '${fieldName ?? "Bu alan"} en az $min karakter olmalı'
        : null;
  }

  /// İl ve ilçe zorunlu kontrolü.
  String? requireProvinceDistrict(String? province, String? district) {
    if (province == null || district == null) {
      return 'İl ve ilçe seç';
    }
    return null;
  }

  /// Gereksiz boşlukları temizle.
  String normalizeInput(String value) => value.trim();
}

extension TrNorm on String? {
  String norm() {
    if (this == null) return '';
    final t = this!.trim();
    return t.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();
  }

  String? normOrNull() =>
      (this == null || this!.trim().isEmpty) ? null : norm();
}

// module/common/package/url_package.dart
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:url_launcher/url_launcher.dart';

typedef LaunchResult = bool;

/// Harita URL’lerini açma yardımcı sınıfı.
/// - Web: direkt Google Maps web
/// - iOS: (opsiyonel) Google Maps → Apple Maps (maps://) → Web
/// - Android: geo: → Web
class UrlPackage {
  const UrlPackage();

  /// Harita açar. Uygulama varsa onu, yoksa web'i dener.
  ///
  /// [lat], [lng] zorunlu.
  /// [label] pin başlığı/arama etiketi (opsiyonel).
  /// [zoom] 1..20 arasında otomatik kırpılır (opsiyonel).
  /// [preferGoogle] iOS’ta önce Google Maps’i dene.
  Future<LaunchResult> openMap({
    required double lat,
    required double lng,
    String? label,
    int? zoom,
    bool preferGoogle = true,
  }) async {
    // ---- Girdi doğrulama / normalize ----
    if (!_isFinite(lat) || !_isFinite(lng)) return false;

    final latStr = _fmt(lat);
    final lngStr = _fmt(lng);
    final safeZoom = _clampZoom(zoom);
    final qLabel = _encode(label);

    // ---- Web: direkt Google Maps ----
    if (kIsWeb) {
      final web = _gmSearch(latStr, lngStr);
      return _launchAny([web]);
    }

    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;

    // ---- Aday URI’lar (öncelik sırası) ----
    final candidates = <Uri>[];

    if (isIOS) {
      if (preferGoogle) {
        // Google Maps app (iOS)
        candidates.add(_gmAppShow(latStr, lngStr, qLabel, safeZoom));
      }
      // Apple Maps (iOS) → maps:// daha güvenilir
      candidates.add(_appleMapsApp(latStr, lngStr, qLabel, safeZoom));

      // (Ekstra) http fallback
      candidates.add(_appleMapsHttp(latStr, lngStr, qLabel, safeZoom));
    }

    if (isAndroid) {
      // Android genel geo: (hangi harita yüklüyse onu açar)
      candidates.add(_geo(latStr, lngStr, qLabel, safeZoom));
    }

    // Genel fallback: Web Google Maps
    candidates.add(_gmSearch(latStr, lngStr));

    return _launchAny(candidates);
  }

  // ─────────────────────── Helpers ───────────────────────

  bool _isFinite(double v) => v.isFinite;

  /// 6 ondalık hassasiyet
  String _fmt(double v) => v.toStringAsFixed(6);

  /// 1..20 arası zoom; null ise hiç ekleme.
  int? _clampZoom(int? z) {
    if (z == null) return null;
    if (z < 1) return 1;
    if (z > 20) return 20;
    return z;
  }

  String _encode(String? s) =>
      s == null || s.trim().isEmpty ? '' : Uri.encodeComponent(s.trim());

  // Google Maps “app” show
  Uri _gmAppShow(String lat, String lng, String label, int? zoom) => Uri.parse(
        'comgooglemaps://?q=$lat,$lng${label.isNotEmpty ? '($label)' : ''}'
        '&center=$lat,$lng${zoom != null ? '&zoom=$zoom' : ''}',
      );

  // Apple Maps (app) → maps://
  Uri _appleMapsApp(String lat, String lng, String label, int? zoom) =>
      Uri.parse(
        'maps://?q=${label.isNotEmpty ? label : '$lat,$lng'}'
        '&ll=$lat,$lng${zoom != null ? '&z=$zoom' : ''}',
      );

  // Apple Maps (http fallback)
  Uri _appleMapsHttp(String lat, String lng, String label, int? zoom) =>
      Uri.parse(
        'http://maps.apple.com/?ll=$lat,$lng'
        '${label.isNotEmpty ? '&q=$label' : ''}'
        '${zoom != null ? '&z=$zoom' : ''}',
      );

  // Android geo:
  Uri _geo(String lat, String lng, String label, int? zoom) => Uri.parse(
        'geo:$lat,$lng?q=$lat,$lng${label.isNotEmpty ? '($label)' : ''}'
        '${zoom != null ? '&z=$zoom' : ''}',
      );

  // Google Maps web search
  Uri _gmSearch(String lat, String lng) => Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );

  Future<LaunchResult> _launchAny(List<Uri> candidates) async {
    for (final uri in candidates) {
      try {
        if (await canLaunchUrl(uri)) {
          final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (ok) return true;
        }
      } catch (_) {
        // sessiz düş
      }
    }
    return false;
  }
}

/// global, her yerden çağır
const urlPackage = UrlPackage();

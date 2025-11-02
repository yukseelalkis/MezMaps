import 'dart:math' as math;
import 'package:flutter/foundation.dart';

@immutable
final class Cemetery {
  final String name;
  /// WGS84 decimal degrees
  final double lat;
  final double lng;

  const Cemetery({required this.name, required this.lat, required this.lng});

  Cemetery copyWith({String? name, double? lat, double? lng}) => Cemetery(
    name: name ?? this.name,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );

  factory Cemetery.fromJson(Map<String, dynamic> j) => Cemetery(
    name: j['name'] as String,
    lat: (j['lat'] as num).toDouble(),
    lng: (j['lng'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {'name': name, 'lat': lat, 'lng': lng};
}

@immutable
final class District {
  final String name;
  final List<Cemetery> cemeteries;

  /// Opsiyonel: ilçe merkez koordinatı (haritada fokus için işe yarar)
  final double? centerLat;
  final double? centerLng;

  const District({
    required this.name,
    this.cemeteries = const [],
    this.centerLat,
    this.centerLng,
  });

  District copyWith({
    String? name,
    List<Cemetery>? cemeteries,
    double? centerLat,
    double? centerLng,
  }) => District(
    name: name ?? this.name,
    cemeteries: cemeteries ?? this.cemeteries,
    centerLat: centerLat ?? this.centerLat,
    centerLng: centerLng ?? this.centerLng,
  );

  factory District.fromJson(Map<String, dynamic> j) => District(
    name: j['name'] as String,
    cemeteries: (j['cemeteries'] as List<dynamic>? ?? const [])
        .map((e) => Cemetery.fromJson(e as Map<String, dynamic>))
        .toList(),
    centerLat: (j['centerLat'] as num?)?.toDouble(),
    centerLng: (j['centerLng'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'cemeteries': cemeteries.map((e) => e.toJson()).toList(),
    if (centerLat != null) 'centerLat': centerLat,
    if (centerLng != null) 'centerLng': centerLng,
  };
}

@immutable
final class Province {
  final String name;
  final List<District> districts;

  /// Opsiyonel: il merkez koordinatı
  final double? centerLat;
  final double? centerLng;

  const Province({
    required this.name,
    this.districts = const [],
    this.centerLat,
    this.centerLng,
  });

  Province copyWith({
    String? name,
    List<District>? districts,
    double? centerLat,
    double? centerLng,
  }) => Province(
    name: name ?? this.name,
    districts: districts ?? this.districts,
    centerLat: centerLat ?? this.centerLat,
    centerLng: centerLng ?? this.centerLng,
  );

  factory Province.fromJson(Map<String, dynamic> j) => Province(
    name: j['name'] as String,
    districts: (j['districts'] as List<dynamic>? ?? const [])
        .map((e) => District.fromJson(e as Map<String, dynamic>))
        .toList(),
    centerLat: (j['centerLat'] as num?)?.toDouble(),
    centerLng: (j['centerLng'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'districts': districts.map((e) => e.toJson()).toList(),
    if (centerLat != null) 'centerLat': centerLat,
    if (centerLng != null) 'centerLng': centerLng,
  };
}

/// --- Küçük yardımcılar ---

/// İki nokta arası km cinsinden mesafe (Haversine)
double haversineKm(double lat1, double lng1, double lat2, double lng2) {
  const r = 6371.0;
  double dLat = _deg2rad(lat2 - lat1);
  double dLng = _deg2rad(lng2 - lng1);
  double a =
      math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_deg2rad(lat1)) *
          math.cos(_deg2rad(lat2)) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return r * c;
}

double _deg2rad(double deg) => deg * math.pi / 180.0;

/// En yakın mezarlığı bul (örnek kullanım)
Cemetery? nearestCemetery({
  required double lat,
  required double lng,
  required List<Province> provinces,
}) {
  Cemetery? best;
  double bestKm = double.infinity;

  for (final p in provinces) {
    for (final d in p.districts) {
      for (final c in d.cemeteries) {
        final km = haversineKm(lat, lng, c.lat, c.lng);
        if (km < bestKm) {
          bestKm = km;
          best = c;
        }
      }
    }
  }
  return best;
}

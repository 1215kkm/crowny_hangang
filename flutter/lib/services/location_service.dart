import 'dart:math';

/// 위치 관련 서비스 — GPS + 한강근처 판단 + 거리 계산
class LocationService {
  LocationService._();

  /// 한강근처 판단 (반경 내 여부)
  static bool isNearby(double userLat, double userLng, double centerLat, double centerLng, int radiusMeters) {
    final distance = _haversine(userLat, userLng, centerLat, centerLng);
    return distance <= radiusMeters;
  }

  /// 두 좌표 간 거리 (미터)
  static double _haversine(double lat1, double lng1, double lat2, double lng2) {
    const R = 6371000.0; // 지구 반지름 (미터)
    final dLat = _toRad(lat2 - lat1);
    final dLng = _toRad(lng2 - lng1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRad(lat1)) * cos(_toRad(lat2)) * sin(dLng / 2) * sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  static double _toRad(double deg) => deg * pi / 180;

  /// Mock: 현재 위치 (여의도 한강공원 근처)
  static double get mockLat => 37.5255;
  static double get mockLng => 126.9340;
}

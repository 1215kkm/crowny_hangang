import 'package:kakao_map_plugin/kakao_map_plugin.dart';

/// 카카오맵 초기화 및 설정
/// 실제 사용 시 카카오 개발자 콘솔에서 앱 키 발급 필요
/// https://developers.kakao.com/
class MapService {
  // TODO: 카카오 개발자 콘솔에서 발급받은 JavaScript 키로 교체
  static const String kakaoMapKey = 'YOUR_KAKAO_MAP_JAVASCRIPT_KEY';

  /// 앱 시작 시 호출 — main.dart에서 runApp 전에 호출
  static void initialize() {
    AuthRepository.initialize(appKey: kakaoMapKey);
  }

  /// 한강 공원 주요 지구 좌표
  static const Map<String, LatLng> districts = {
    'yeouido': LatLng(37.5283, 126.9346),   // 여의도
    'ttukseom': LatLng(37.5310, 127.0667),  // 뚝섬
    'banpo': LatLng(37.5097, 126.9950),     // 반포
    'jamsil': LatLng(37.5175, 127.0867),    // 잠실
    'mangwon': LatLng(37.5567, 126.8964),   // 망원
    'ichon': LatLng(37.5170, 126.9717),     // 이촌
    'jamwon': LatLng(37.5148, 127.0100),    // 잠원
    'gwangnaru': LatLng(37.5467, 127.1200), // 광나루
    'yanghwa': LatLng(37.5367, 126.8900),   // 양화
    'nanji': LatLng(37.5667, 126.8750),     // 난지
    'seonyudo': LatLng(37.5417, 126.8983),  // 선유도
  };

  /// 기본 지구 (여의도)
  static LatLng get defaultCenter => districts['yeouido']!;
}

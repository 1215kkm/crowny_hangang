/// 효과음 서비스 — Flutter에서 코드 기반 효과음 재생
///
/// Web: Web Audio API (HTML과 동일)
/// Mobile: audioplayers 패키지 또는 tone generator
///
/// 현재는 인터페이스만 정의. 실제 구현은 플랫폼별로.
class SoundService {
  SoundService._();

  /// 효과음 타입
  static const String tap = 'tap';           // 버튼 탭 — "톡"
  static const String ding = 'ding';         // 눈치게임 — "딩!"
  static const String buzz = 'buzz';         // 탈락/오답 — "빵!"
  static const String correct = 'correct';   // 정답 — "딩동댕!"
  static const String up = 'up';             // 업다운 UP — "띵↑"
  static const String down = 'down';         // 업다운 DOWN — "뚱↓"
  static const String countdown = 'countdown'; // 카운트다운 — "똑"
  static const String fanfare = 'fanfare';   // 결과 발표 — "짠!"

  /// 효과음 재생
  static void play(String type) {
    // TODO: 플랫폼별 구현
    // Web → dart:html AudioContext
    // Mobile → audioplayers 패키지
    // 현재는 no-op (Mock)
    print('🔊 Sound: $type');
  }

  /// 모든 사운드 정지
  static void stopAll() {
    print('🔇 Sound: stop all');
  }
}

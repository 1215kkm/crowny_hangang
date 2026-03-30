/// 미션 데이터 모델 — JSON 데이터 드리븐 설계
/// 서버에서 JSON으로 관리, 앱 업데이트 없이 추가/수정/삭제 가능
class MissionPhase {
  final String id;
  final String name;
  final String icon; // Material icon name
  final List<MissionItem> missions;

  const MissionPhase({
    required this.id,
    required this.name,
    required this.icon,
    required this.missions,
  });

  factory MissionPhase.fromJson(Map<String, dynamic> json) {
    return MissionPhase(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      missions: (json['missions'] as List)
          .map((m) => MissionItem.fromJson(m))
          .toList(),
    );
  }
}

class MissionItem {
  final String id;
  final String type; // talk, photo, quiz, action, vote
  final String text;
  final String sub;
  final String icon; // Material icon name
  final int timerSec;
  final List<String> difficulty; // easy, normal, hard
  final List<String> tags; // korean, foreigner
  final String? season; // spring, summer, fall, winter
  final String? district; // yeouido, ttukseom, banpo, etc.
  final bool active;
  final Map<String, dynamic>? config; // 타입별 추가 설정

  const MissionItem({
    required this.id,
    required this.type,
    required this.text,
    required this.sub,
    required this.icon,
    required this.timerSec,
    this.difficulty = const ['easy', 'normal', 'hard'],
    this.tags = const ['korean', 'foreigner'],
    this.season,
    this.district,
    this.active = true,
    this.config,
  });

  factory MissionItem.fromJson(Map<String, dynamic> json) {
    return MissionItem(
      id: json['id'],
      type: json['type'] ?? 'talk',
      text: json['text'],
      sub: json['sub'] ?? '',
      icon: json['icon'] ?? 'chat',
      timerSec: json['timer_sec'] ?? 120,
      difficulty: List<String>.from(json['difficulty'] ?? ['easy', 'normal', 'hard']),
      tags: List<String>.from(json['tags'] ?? ['korean', 'foreigner']),
      season: json['season'],
      district: json['district'],
      active: json['active'] ?? true,
      config: json['config'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'text': text,
    'sub': sub,
    'icon': icon,
    'timer_sec': timerSec,
    'difficulty': difficulty,
    'tags': tags,
    'season': season,
    'district': district,
    'active': active,
    'config': config,
  };
}

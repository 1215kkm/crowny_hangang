class UserModel {
  final String id;
  final String nickname;
  final String activity; // 현재 활동: chimaek, running, walk, picnic, pet, bike, photo
  final String activityLabel;
  final String statusMessage;
  final int distanceMeters;
  final double latitude;
  final double longitude;
  final int trustLevel; // 0~4
  final double hangangTemp; // 한강 온도 (36.5 기본)
  final List<String> languages; // ["KR", "EN", "JP"]
  final List<String> mannerTags;
  final int meetupCount;
  final bool isOnline;
  final String? avatarIcon; // Material icon name
  final String gradientType; // pink, purple, blue, orange

  const UserModel({
    required this.id,
    required this.nickname,
    required this.activity,
    required this.activityLabel,
    required this.statusMessage,
    required this.distanceMeters,
    this.latitude = 37.5283,
    this.longitude = 126.9346,
    this.trustLevel = 0,
    this.hangangTemp = 36.5,
    this.languages = const ['KR'],
    this.mannerTags = const [],
    this.meetupCount = 0,
    this.isOnline = true,
    this.avatarIcon,
    this.gradientType = 'purple',
  });
}

class ContactStage {
  static const int nickname = 1; // 한강 닉네임만
  static const int chat = 2; // 앱 내 채팅
  static const int social = 3; // 카카오/인스타/전화번호
  static const int full = 4; // 상세 프로필
}

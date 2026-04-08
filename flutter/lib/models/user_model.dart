class UserModel {
  final String id;
  final String nickname;
  final String activity;
  final String activityLabel;
  final String statusMessage;
  final int distanceMeters;
  final double latitude;
  final double longitude;
  final int trustScore; // 신뢰도 (0~100, 참여자가 +/- 평가)
  final double hangangTemp;
  final List<String> languages;
  final List<String> mannerTags;
  final int meetupCount;
  final bool isOnline;
  final String? avatarIcon;
  final String gradientType;
  // 매칭 필터용 추가 필드
  final String mood; // play, alone
  final List<String> hobbies;
  final List<String> interests;
  final String? recentMoimTitle; // 최근 참여 모임

  const UserModel({
    required this.id,
    required this.nickname,
    required this.activity,
    required this.activityLabel,
    required this.statusMessage,
    required this.distanceMeters,
    this.latitude = 37.5283,
    this.longitude = 126.9346,
    this.trustScore = 50,
    this.hangangTemp = 36.5,
    this.languages = const ['KR'],
    this.mannerTags = const [],
    this.meetupCount = 0,
    this.isOnline = true,
    this.avatarIcon,
    this.gradientType = 'purple',
    this.mood = 'play',
    this.hobbies = const [],
    this.interests = const [],
    this.recentMoimTitle,
  });
}

class ContactStage {
  static const int nickname = 1; // 한강 닉네임만
  static const int chat = 2; // 앱 내 채팅
  static const int social = 3; // 카카오/인스타/전화번호
  static const int full = 4; // 상세 프로필
}

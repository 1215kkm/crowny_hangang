import '../models/user_model.dart';
import '../models/event_model.dart';
import '../models/chat_model.dart';
import '../models/mission_model.dart';

class MockData {
  MockData._();

  // ── 근처 사용자 ──
  static const List<UserModel> nearbyUsers = [
    UserModel(
      id: 'u1',
      nickname: '뚝섬러닝러',
      activity: 'running',
      activityLabel: '러닝 중',
      statusMessage: '같이 달릴 사람~',
      distanceMeters: 120,
      trustLevel: 3,
      hangangTemp: 38.5,
      languages: ['KR'],
      mannerTags: ['시간 잘 지켜요', '대화 재밌어요', '분위기 메이커'],
      meetupCount: 12,
      avatarIcon: 'directions_run',
      gradientType: 'pink',
    ),
    UserModel(
      id: 'u2',
      nickname: '여의도치맥왕',
      activity: 'chimaek',
      activityLabel: '치맥 중',
      statusMessage: '합석 환영!',
      distanceMeters: 200,
      trustLevel: 2,
      hangangTemp: 37.8,
      languages: ['KR'],
      mannerTags: ['음식 잘 나눠줘요', '배려심 넘쳐요'],
      meetupCount: 8,
      avatarIcon: 'sports_bar',
      gradientType: 'blue',
    ),
    UserModel(
      id: 'u3',
      nickname: 'SakuraLover',
      activity: 'photo',
      activityLabel: '사진 촬영',
      statusMessage: '한강 처음이에요!',
      distanceMeters: 350,
      trustLevel: 1,
      hangangTemp: 36.8,
      languages: ['JP', 'EN'],
      mannerTags: ['사진 잘 찍어줘요'],
      meetupCount: 2,
      avatarIcon: 'photo_camera',
      gradientType: 'orange',
    ),
    UserModel(
      id: 'u4',
      nickname: '한강멍멍이',
      activity: 'pet',
      activityLabel: '산책 중',
      statusMessage: '강아지 좋아하시는 분!',
      distanceMeters: 450,
      trustLevel: 2,
      hangangTemp: 37.2,
      languages: ['KR'],
      mannerTags: ['배려심 넘쳐요', '시간 잘 지켜요'],
      meetupCount: 5,
      avatarIcon: 'pets',
      gradientType: 'purple',
    ),
  ];

  // ── 번개 모임 ──
  static final List<EventModel> flashEvents = [
    EventModel(
      id: 'e1',
      title: '치킨 같이 시켜요!',
      icon: 'restaurant',
      gradientType: 'pink',
      location: '여의도 2지구',
      district: 'yeouido',
      startTime: DateTime.now(),
      maxPeople: 4,
      currentPeople: 2,
      participantAvatars: ['pink', 'blue'],
      type: EventType.flash,
    ),
    EventModel(
      id: 'e2',
      title: '한강 러닝 5km',
      icon: 'directions_run',
      gradientType: 'purple',
      location: '뚝섬→잠실',
      district: 'ttukseom',
      startTime: DateTime.now().add(const Duration(minutes: 30)),
      maxPeople: 5,
      currentPeople: 1,
      participantAvatars: ['purple'],
      type: EventType.flash,
    ),
    EventModel(
      id: 'e3',
      title: '야경 산책',
      icon: 'nightlight',
      gradientType: 'blue',
      location: '반포대교',
      district: 'banpo',
      startTime: DateTime.now().add(const Duration(hours: 1)),
      maxPeople: 6,
      currentPeople: 3,
      participantAvatars: ['pink', 'blue', 'orange'],
      type: EventType.flash,
    ),
  ];

  // ── 미션 데이터 (JSON 드리븐) ──
  static final List<MissionPhase> missionPhases = [
    MissionPhase(
      id: 'warmup',
      name: '워밍업',
      icon: 'emoji_people',
      missions: [
        const MissionItem(
          id: 'm1',
          type: 'talk',
          text: '오늘 한강 온 이유 공유',
          sub: '서로 한 문장씩!',
          icon: 'chat',
          timerSec: 120,
        ),
        const MissionItem(
          id: 'm2',
          type: 'talk',
          text: '공통점 3개 찾기',
          sub: '의외의 공통점을 찾아보세요',
          icon: 'search',
          timerSec: 180,
        ),
      ],
    ),
    MissionPhase(
      id: 'activity',
      name: '액티비티',
      icon: 'sports_esports',
      missions: [
        const MissionItem(
          id: 'm3',
          type: 'photo',
          text: '가장 웃긴 셀카 찍기!',
          sub: '서로 찍어주고 가장 웃긴 사진 뽑기',
          icon: 'photo_camera',
          timerSec: 180,
          config: {'require_photo': true, 'camera_mode': 'front'},
        ),
        const MissionItem(
          id: 'm4',
          type: 'action',
          text: '주변 특이한 것 찾기',
          sub: '가장 특이한 것을 발견하는 사람이 승리!',
          icon: 'search',
          timerSec: 300,
        ),
      ],
    ),
    MissionPhase(
      id: 'deep_talk',
      name: '대화 심화',
      icon: 'psychology',
      missions: [
        const MissionItem(
          id: 'm5',
          type: 'talk',
          text: '감동/웃긴 일 공유',
          sub: '최근에 있었던 이야기 하나씩',
          icon: 'chat',
          timerSec: 300,
        ),
        const MissionItem(
          id: 'm6',
          type: 'talk',
          text: '한강 음식 추천',
          sub: '서로에게 꼭 먹어봐야 할 음식 추천',
          icon: 'ramen_dining',
          timerSec: 300,
        ),
      ],
    ),
    MissionPhase(
      id: 'bonus',
      name: '보너스',
      icon: 'star',
      missions: [
        const MissionItem(
          id: 'm7',
          type: 'talk',
          text: '오늘 만남 한 문장 요약',
          sub: '오늘 이 만남을 한 문장으로!',
          icon: 'edit',
          timerSec: 120,
        ),
        const MissionItem(
          id: 'm8',
          type: 'talk',
          text: '다음에 같이 하고 싶은 것',
          sub: '재미있는 제안을 해보세요',
          icon: 'lightbulb',
          timerSec: 180,
        ),
      ],
    ),
  ];

  // ── 채팅방 ──
  static final List<ChatRoom> chatRooms = [
    ChatRoom(
      id: 'c1',
      partnerNickname: '여의도치맥왕',
      partnerIcon: 'sports_bar',
      partnerGradient: 'blue',
      lastMessage: '오 좋아요! 어디서 만날까요?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 2)),
      unreadCount: 1,
    ),
    ChatRoom(
      id: 'c2',
      partnerNickname: 'SakuraLover',
      partnerIcon: 'photo_camera',
      partnerGradient: 'orange',
      lastMessage: 'Nice to meet you! 😊',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      unreadCount: 0,
    ),
  ];

  // ── 활동 목록 ──
  static const List<Map<String, dynamic>> activities = [
    {'id': 'chimaek', 'name': '치맥', 'icon': 'sports_bar', 'gradient': 'pink', 'count': 5},
    {'id': 'running', 'name': '러닝', 'icon': 'directions_run', 'gradient': 'purple', 'count': 3},
    {'id': 'walk', 'name': '산책', 'icon': 'hiking', 'gradient': 'blue', 'count': 2},
    {'id': 'picnic', 'name': '피크닉', 'icon': 'deck', 'gradient': 'orange', 'count': 1},
  ];
}

import '../models/user_model.dart';
import '../models/event_model.dart';
import '../models/chat_model.dart';
import '../models/mission_model.dart';

class MockData {
  MockData._();

  // ── 근처 사용자 (매칭 필터용 필드 추가) ──
  static const List<UserModel> nearbyUsers = [
    UserModel(
      id: 'u1',
      nickname: '뚝섬러닝러',
      activity: 'running',
      activityLabel: '러닝 중',
      statusMessage: '같이 달릴 사람 찾아요! 5km 가볍게 뛰고 편의점 라면 ㄱㄱ 🍜',
      distanceMeters: 120,
      trustLevel: 3,
      hangangTemp: 38.5,
      languages: ['KR'],
      mannerTags: ['시간 잘 지켜요', '대화 재밌어요', '분위기 메이커'],
      meetupCount: 12,
      avatarIcon: 'directions_run',
      gradientType: 'pink',
      mood: 'play',
      hobbies: ['러닝', '산책'],
      interests: ['운동'],
      recentMoimTitle: '한강 러닝 크루',
    ),
    UserModel(
      id: 'u2',
      nickname: '여의도치맥왕',
      activity: 'chimaek',
      activityLabel: '치맥 중',
      statusMessage: '합석 환영합니다! 치킨 시켜놨어요 🍗🍺',
      distanceMeters: 200,
      trustLevel: 5,
      hangangTemp: 42.1,
      languages: ['KR'],
      mannerTags: ['맛집 마스터', '유머 만렙', '분위기 메이커'],
      meetupCount: 8,
      avatarIcon: 'sports_bar',
      gradientType: 'blue',
      mood: 'play',
      hobbies: ['치맥', '맛집'],
      interests: ['맛집탐방'],
      recentMoimTitle: '여의도 치맥 모임',
    ),
    UserModel(
      id: 'u3',
      nickname: 'SakuraLover',
      activity: 'photo',
      activityLabel: '사진 촬영',
      statusMessage: '한강 처음이에요! 같이 사진 찍어요 📸',
      distanceMeters: 350,
      trustLevel: 1,
      hangangTemp: 36.8,
      languages: ['JP', 'EN'],
      mannerTags: ['사진 잘 찍어줘요'],
      meetupCount: 2,
      avatarIcon: 'photo_camera',
      gradientType: 'orange',
      mood: 'play',
      hobbies: ['사진', '산책'],
      interests: ['야경'],
      recentMoimTitle: '야경 사진 찍을 사람',
    ),
    UserModel(
      id: 'u4',
      nickname: '한강멍멍이',
      activity: 'pet',
      activityLabel: '산책 중',
      statusMessage: '멍멍이와 산책 중~ 🐶',
      distanceMeters: 450,
      trustLevel: 2,
      hangangTemp: 37.2,
      languages: ['KR'],
      mannerTags: ['배려심 넘쳐요', '시간 잘 지켜요'],
      meetupCount: 5,
      avatarIcon: 'pets',
      gradientType: 'purple',
      mood: 'alone',
      hobbies: ['반려동물', '산책'],
      interests: ['운동'],
      recentMoimTitle: '편의점 라면 파티',
    ),
    UserModel(
      id: 'u5',
      nickname: '망원카페러',
      activity: 'cafe',
      activityLabel: '카페',
      statusMessage: '카페에서 책 읽는 중 ☕📖',
      distanceMeters: 500,
      trustLevel: 3,
      hangangTemp: 37.8,
      languages: ['KR'],
      mannerTags: ['조용히 함께해요', '배려심 넘쳐요'],
      meetupCount: 3,
      avatarIcon: 'local_cafe',
      gradientType: 'blue',
      mood: 'alone',
      hobbies: ['카페', '독서'],
      interests: ['독서'],
      recentMoimTitle: null,
    ),
  ];

  // ── 총 접속자 수 (Mock) ──
  static const int totalOnline = 127;

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
        const MissionItem(id: 'm1', type: 'talk', text: '오늘 한강 온 이유 공유', sub: '서로 한 문장씩!', icon: 'chat', timerSec: 120),
        const MissionItem(id: 'm2', type: 'talk', text: '공통점 3개 찾기', sub: '의외의 공통점을 찾아보세요', icon: 'search', timerSec: 180),
      ],
    ),
    MissionPhase(
      id: 'activity',
      name: '액티비티',
      icon: 'sports_esports',
      missions: [
        const MissionItem(id: 'm3', type: 'photo', text: '가장 웃긴 셀카 찍기!', sub: '서로 찍어주고 가장 웃긴 사진 뽑기', icon: 'photo_camera', timerSec: 180, config: {'require_photo': true, 'camera_mode': 'front'}),
        const MissionItem(id: 'm4', type: 'action', text: '주변 특이한 것 찾기', sub: '가장 특이한 것을 발견하는 사람이 승리!', icon: 'search', timerSec: 300),
      ],
    ),
    MissionPhase(
      id: 'deep_talk',
      name: '대화 심화',
      icon: 'psychology',
      missions: [
        const MissionItem(id: 'm5', type: 'talk', text: '감동/웃긴 일 공유', sub: '최근에 있었던 이야기 하나씩', icon: 'chat', timerSec: 300),
        const MissionItem(id: 'm6', type: 'talk', text: '한강 음식 추천', sub: '서로에게 꼭 먹어봐야 할 음식 추천', icon: 'ramen_dining', timerSec: 300),
      ],
    ),
    MissionPhase(
      id: 'bonus',
      name: '보너스',
      icon: 'star',
      missions: [
        const MissionItem(id: 'm7', type: 'talk', text: '오늘 만남 한 문장 요약', sub: '오늘 이 만남을 한 문장으로!', icon: 'edit', timerSec: 120),
        const MissionItem(id: 'm8', type: 'talk', text: '다음에 같이 하고 싶은 것', sub: '재미있는 제안을 해보세요', icon: 'lightbulb', timerSec: 180),
      ],
    ),
  ];

  // ── 모임방 ──
  static final List<MoimRoom> moimRooms = [
    MoimRoom(
      id: 'r1', creatorId: 'u2', creatorNickname: '여의도치맥왕',
      creatorIcon: 'sports_bar', creatorGradient: 'blue', creatorLv: 5,
      creatorTemp: 42.1, creatorTags: ['맛집 마스터', '유머 만렙', '분위기 메이커'],
      title: '여의도 치맥 모임', description: '합석 환영합니다! 치킨 시켜놨어요 🍗🍺',
      district: '여의도', maxPeople: 5, currentPeople: 3,
      isJoined: true, isPrivate: false, unreadCount: 2,
      lastMessage: '치킨 주문했어요! 빨리 오세요~ 🍗',
    ),
    MoimRoom(
      id: 'r2', creatorId: 'u1', creatorNickname: '뚝섬러닝러',
      creatorIcon: 'directions_run', creatorGradient: 'pink', creatorLv: 3,
      creatorTemp: 38.5, creatorTags: ['시간 잘 지켜요', '대화 재밌어요', '분위기 메이커'],
      title: '한강 러닝 크루', description: '같이 달릴 사람! 5km 가볍게 뛰고 편의점 라면 ㄱㄱ 🍜',
      district: '뚝섬', maxPeople: 4, currentPeople: 2,
      isJoined: false, isPrivate: true,
      mission: const RoomMission(id: 'm1', roomId: 'r2', missionType: 'selfie', title: '가장 웃긴 셀카', timerSec: 180),
    ),
    MoimRoom(
      id: 'r3', creatorId: 'u3', creatorNickname: 'SakuraLover',
      creatorIcon: 'photo_camera', creatorGradient: 'orange', creatorLv: 1,
      creatorTemp: 36.8, creatorTags: ['사진 잘 찍어줘요'],
      title: '야경 사진 찍을 사람', description: '한강 처음이에요! 같이 사진 찍어요 📸',
      district: '반포', maxPeople: 3, currentPeople: 1,
      isJoined: false, isPrivate: false,
      mission: const RoomMission(id: 'm2', roomId: 'r3', missionType: 'find_unusual', title: '주변 특이한 것 찾기', timerSec: 300),
    ),
    MoimRoom(
      id: 'r4', creatorId: 'u4', creatorNickname: '한강멍멍이',
      creatorIcon: 'pets', creatorGradient: 'purple', creatorLv: 2,
      creatorTemp: 37.2, creatorTags: ['배려심 넘쳐요', '시간 잘 지켜요'],
      title: '편의점 라면 파티', description: '라면 좋아하는 사람 모여라~ 🍜',
      district: '잠실', maxPeople: 6, currentPeople: 4,
      isJoined: true, isPrivate: false,
    ),
    MoimRoom(
      id: 'r5', creatorId: 'u5', creatorNickname: '망원자전거',
      creatorIcon: 'pedal_bike', creatorGradient: 'blue', creatorLv: 4,
      creatorTemp: 39.5, creatorTags: ['시간 잘 지켜요', '대화 재밌어요'],
      title: '자전거 한강 종주', description: '종주 같이 하실 분! 속도는 맞춰드려요 🚴',
      district: '망원', maxPeople: 3, currentPeople: 2,
      isJoined: false, isPrivate: true,
      mission: const RoomMission(id: 'm3', roomId: 'r5', missionType: 'voice_intro', title: '본인 소개 (10초 음성)', timerSec: 60),
    ),
  ];

  // ── 채팅 메시지 Mock ──
  static final List<ChatMessage> mockMessages = [
    ChatMessage(id: 'msg1', senderId: 'u2', senderNickname: '여의도치맥왕', senderIcon: 'sports_bar', senderGradient: 'blue', text: '치킨 주문했어요! 빨리 오세요~ 🍗', timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isMe: false),
    ChatMessage(id: 'msg2', senderId: 'me', senderNickname: '나', text: '오 좋아요! 어디서 만날까요?', timestamp: DateTime.now().subtract(const Duration(minutes: 4)), isMe: true),
    ChatMessage(id: 'msg3', senderId: 'u2', senderNickname: '여의도치맥왕', senderIcon: 'sports_bar', senderGradient: 'blue', text: '여의도 2지구 편의점 앞이요!', timestamp: DateTime.now().subtract(const Duration(minutes: 3)), isMe: false),
    ChatMessage(id: 'msg4', senderId: 'system', senderNickname: '시스템', text: '뚝섬러닝러님이 입장했습니다', timestamp: DateTime.now().subtract(const Duration(minutes: 2)), type: MessageType.system, isMe: false),
    ChatMessage(id: 'msg5', senderId: 'u1', senderNickname: '뚝섬러닝러', senderIcon: 'directions_run', senderGradient: 'pink', text: '안녕하세요! 저도 합류합니다 🏃', timestamp: DateTime.now().subtract(const Duration(minutes: 1)), isMe: false),
  ];

  // ── 활동 목록 ──
  static const List<Map<String, dynamic>> activities = [
    {'id': 'chimaek', 'name': '치맥', 'icon': 'sports_bar', 'gradient': 'pink', 'count': 5},
    {'id': 'running', 'name': '러닝', 'icon': 'directions_run', 'gradient': 'purple', 'count': 3},
    {'id': 'walk', 'name': '산책', 'icon': 'hiking', 'gradient': 'blue', 'count': 2},
    {'id': 'picnic', 'name': '피크닉', 'icon': 'deck', 'gradient': 'orange', 'count': 1},
  ];
}

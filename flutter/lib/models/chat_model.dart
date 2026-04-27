/// 모임방 모델 (기존 ChatRoom 대체)
class MoimRoom {
  final String id;
  final String creatorId;
  final String creatorNickname;
  final String creatorIcon;
  final String creatorGradient;
  final int creatorLv;
  final double creatorTemp;
  final List<String> creatorTags;
  final String title;
  final String? description;
  final String district;
  final String category; // play, share
  final int radiusKm; // 1, 2, 3, 0=전체
  final int maxPeople;
  final int currentPeople;
  final bool isJoined;
  final bool isPrivate;
  final int unreadCount;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final RoomMission? mission;

  const MoimRoom({
    required this.id,
    required this.creatorId,
    required this.creatorNickname,
    required this.creatorIcon,
    required this.creatorGradient,
    this.creatorLv = 1,
    this.creatorTemp = 36.5,
    this.creatorTags = const [],
    required this.title,
    this.description,
    required this.district,
    this.category = 'play',
    this.radiusKm = 2,
    required this.maxPeople,
    required this.currentPeople,
    this.isJoined = false,
    this.isPrivate = false,
    this.unreadCount = 0,
    this.lastMessage,
    this.lastMessageTime,
    this.mission,
  });

  bool get isLocked => isPrivate && !isJoined;
  bool get isFull => currentPeople >= maxPeople;
}

/// 모임방 내 미션
class RoomMission {
  final String id;
  final String roomId;
  final String missionType; // selfie, find_unusual, share_story, share_today, voice_intro, custom
  final String title;
  final String? description;
  final List<String> attachmentTypes; // photo, voice, text
  final int timerSec;
  final String status; // pending, active, completed

  const RoomMission({
    required this.id,
    required this.roomId,
    required this.missionType,
    required this.title,
    this.description,
    this.attachmentTypes = const ['text'],
    this.timerSec = 180,
    this.status = 'active',
  });

  String get iconName {
    switch (missionType) {
      case 'selfie': return 'photo_camera';
      case 'find_unusual': return 'search';
      case 'share_story': return 'chat';
      case 'share_today': return 'edit';
      case 'voice_intro': return 'mic';
      case 'custom': return 'tune';
      default: return 'star';
    }
  }
}

/// 미션 제출물
class MissionSubmission {
  final String id;
  final String missionId;
  final String userId;
  final String userNickname;
  final String type; // photo, voice, text
  final String content;
  final DateTime createdAt;

  const MissionSubmission({
    required this.id,
    required this.missionId,
    required this.userId,
    required this.userNickname,
    required this.type,
    required this.content,
    required this.createdAt,
  });
}

/// 채팅 메시지
class ChatMessage {
  final String id;
  final String senderId;
  final String senderNickname;
  final String? senderIcon;
  final String? senderGradient;
  final String text;
  final DateTime timestamp;
  final MessageType type;
  final bool isMe;
  final String? missionId;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderNickname,
    this.senderIcon,
    this.senderGradient,
    required this.text,
    required this.timestamp,
    this.type = MessageType.text,
    required this.isMe,
    this.missionId,
  });
}

enum MessageType { text, image, voice, missionPhoto, missionVoice, missionText, system, location, poll, randomOrder, dutchPay }

/// 1:1 DM 방
class DmRoom {
  final String id;
  final String partnerId;
  final String partnerNickname;
  final String partnerIcon;
  final String partnerGradient;
  final String? lastMessage;
  final String? lastTime;
  final int unreadCount;

  const DmRoom({
    required this.id,
    required this.partnerId,
    required this.partnerNickname,
    this.partnerIcon = 'person',
    this.partnerGradient = 'purple',
    this.lastMessage,
    this.lastTime,
    this.unreadCount = 0,
  });
}

/// 프리셋 미션 (모집글 작성 시 선택용)
class PresetMission {
  final String type;
  final String name;
  final String icon;
  final String description;
  final List<String> attachmentTypes;
  final int defaultTimerSec;

  const PresetMission({
    required this.type,
    required this.name,
    required this.icon,
    required this.description,
    required this.attachmentTypes,
    this.defaultTimerSec = 180,
  });

  static const List<PresetMission> presets = [
    PresetMission(type: 'none', name: '미션 없음', icon: 'block', description: '미션 없이 자유롭게', attachmentTypes: []),
    PresetMission(type: 'selfie', name: '가장 웃긴 셀카 📸', icon: 'photo_camera', description: '서로 찍어주고 가장 웃긴 사진 뽑기', attachmentTypes: ['photo']),
    PresetMission(type: 'find_unusual', name: '주변 특이한 것 찾기 🔍', icon: 'search', description: '가장 특이한 것을 발견하세요', attachmentTypes: ['photo']),
    PresetMission(type: 'share_story', name: '감동/웃긴 일 공유 💬', icon: 'chat', description: '최근에 있었던 이야기 하나씩', attachmentTypes: ['text']),
    PresetMission(type: 'share_today', name: '오늘 일 공유 📝', icon: 'edit', description: '오늘 하루를 공유해보세요', attachmentTypes: ['text']),
    PresetMission(type: 'voice_intro', name: '본인 소개 (10초 음성) 🎙', icon: 'mic', description: '10초 안에 자기소개!', attachmentTypes: ['voice'], defaultTimerSec: 60),
    PresetMission(type: 'custom', name: '직접 정하기 ✏️', icon: 'tune', description: '사진/음성/글 중 선택', attachmentTypes: ['photo', 'voice', 'text']),
  ];
}

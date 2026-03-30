class ChatRoom {
  final String id;
  final String partnerNickname;
  final String partnerIcon; // Material icon name
  final String partnerGradient;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isActive; // 현재 매칭 중

  const ChatRoom({
    required this.id,
    required this.partnerNickname,
    required this.partnerIcon,
    required this.partnerGradient,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isActive = true,
  });
}

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final MessageType type;
  final bool isMe;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.type = MessageType.text,
    required this.isMe,
  });
}

enum MessageType { text, image, voice, moodCard, system }

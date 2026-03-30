class EventModel {
  final String id;
  final String title;
  final String icon; // Material icon name
  final String gradientType; // pink, purple, blue, orange
  final String location;
  final String district; // yeouido, ttukseom, banpo
  final DateTime startTime;
  final int maxPeople;
  final int currentPeople;
  final List<String> participantAvatars; // gradient types
  final EventType type;
  final String? description;

  const EventModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.gradientType,
    required this.location,
    required this.district,
    required this.startTime,
    required this.maxPeople,
    required this.currentPeople,
    this.participantAvatars = const [],
    this.type = EventType.flash,
    this.description,
  });

  bool get isFull => currentPeople >= maxPeople;
  bool get isClosingSoon => currentPeople >= maxPeople - 1;
}

enum EventType { flash, regular, seasonal, theme }

class BoardPost {
  final String id;
  final String authorNickname;
  final String authorIcon;
  final String authorGradient;
  final String district; // yeouido, ttukseom, banpo, all(자유)
  final String category; // free, info, food, photo, question
  final String title;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;
  final int viewCount;
  final bool isLiked;
  final List<String>? imageUrls;

  const BoardPost({
    required this.id,
    required this.authorNickname,
    required this.authorIcon,
    required this.authorGradient,
    required this.district,
    required this.category,
    required this.title,
    required this.content,
    required this.createdAt,
    this.likeCount = 0,
    this.commentCount = 0,
    this.viewCount = 0,
    this.isLiked = false,
    this.imageUrls,
  });
}

class BoardComment {
  final String id;
  final String postId;
  final String authorNickname;
  final String authorIcon;
  final String authorGradient;
  final String content;
  final DateTime createdAt;
  final int likeCount;

  const BoardComment({
    required this.id,
    required this.postId,
    required this.authorNickname,
    required this.authorIcon,
    required this.authorGradient,
    required this.content,
    required this.createdAt,
    this.likeCount = 0,
  });
}

class BoardCategory {
  static const Map<String, String> labels = {
    'free': '자유',
    'info': '정보',
    'food': '맛집',
    'photo': '사진',
    'question': '질문',
  };

  static const Map<String, String> icons = {
    'free': 'chat_bubble',
    'info': 'info',
    'food': 'restaurant',
    'photo': 'photo_camera',
    'question': 'help',
  };
}

class HangangDistrict {
  static const Map<String, String> labels = {
    'all': '전체',
    'yeouido': '여의도',
    'ttukseom': '뚝섬',
    'banpo': '반포',
    'jamsil': '잠실',
    'mangwon': '망원',
    'ichon': '이촌',
  };
}

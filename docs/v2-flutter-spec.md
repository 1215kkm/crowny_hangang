# Flutter v2 변경 스펙

## 1. 수정할 파일 (이미 완료)

### widgets/crowny_bottom_nav.dart
- 5탭→4탭: 미션 제거
- items: home, waving_hand(매칭), forum(채팅), person(프로필)

### screens/main_shell.dart
- IndexedStack 4개: Home, Matching, ChatList, Profile
- MissionScreen import 제거

### models/user_model.dart
추가 필드:
```dart
final String mood; // 'play' or 'alone'
final List<String> hobbies;
final List<String> interests;
final String? recentMoimTitle;
```

### models/chat_model.dart
완전 교체:
- `MoimRoom` — 모임방 (id, creatorId, title, district, maxPeople, currentPeople, isJoined, isPrivate, unreadCount, mission, creatorTags, creatorTemp 등)
- `RoomMission` — 방 미션 (id, roomId, missionType, title, attachmentTypes, timerSec, status)
- `MissionSubmission` — 제출물 (id, missionId, userId, type, content)
- `ChatMessage` — 채팅 메시지 (id, senderId, text, timestamp, type, isMe)
- `MessageType` enum: text, image, voice, missionPhoto, missionVoice, missionText, system
- `PresetMission` — 프리셋 미션 목록 (static const presets)

### widgets/mission_timer.dart (신규, 이미 완료)
- MissionTimerWidget: 원형 SVG 타이머
- totalSeconds, onComplete, size 파라미터
- CustomPainter로 보라→핑크 그라데이션 원형 진행바

---

## 2. 수정할 파일 (아직)

### mock/mock_data.dart
기존 Mock 데이터에 추가:

```dart
// 모임방 목록
static final List<MoimRoom> mockRooms = [
  MoimRoom(
    id: 'r1', creatorId: 'u2', creatorNickname: '여의도치맥왕',
    creatorIcon: 'sports_bar', creatorGradient: 'blue', creatorLv: 5,
    creatorTemp: 42.1, creatorTags: ['맛집 마스터', '유머 만렙', '분위기 메이커'],
    title: '여의도 치맥 모임', district: '여의도',
    maxPeople: 5, currentPeople: 3, isJoined: true, isPrivate: false,
    unreadCount: 2, lastMessage: '치킨 주문했어요!',
  ),
  MoimRoom(
    id: 'r2', creatorId: 'u1', creatorNickname: '뚝섬러닝러',
    creatorIcon: 'directions_run', creatorGradient: 'pink', creatorLv: 3,
    creatorTemp: 38.5, creatorTags: ['시간 잘 지켜요', '대화 재밌어요', '분위기 메이커'],
    title: '한강 러닝 크루', district: '뚝섬',
    maxPeople: 4, currentPeople: 2, isJoined: false, isPrivate: true,
    mission: RoomMission(id:'m1', roomId:'r2', missionType:'selfie',
      title:'가장 웃긴 셀카', timerSec:180),
  ),
  // ... r3~r5 동일 패턴
];

// 사용자 mock에 mood, hobbies, recentMoimTitle 추가
static final List<UserModel> mockUsers = [
  UserModel(
    id: 'u1', nickname: '뚝섬러닝러', activity: 'running',
    activityLabel: '러닝 중', statusMessage: '같이 달릴 사람~',
    distanceMeters: 120, avatarIcon: 'directions_run', gradientType: 'pink',
    trustLevel: 3, hangangTemp: 38.5,
    mood: 'play', hobbies: ['러닝', '산책'], recentMoimTitle: '한강 러닝 크루',
    mannerTags: ['시간 잘 지켜요', '대화 재밌어요', '분위기 메이커'],
  ),
  // ... u2~u5
];

// 채팅 메시지 mock
static final List<ChatMessage> mockMessages = [
  ChatMessage(id:'m1', senderId:'u2', senderNickname:'여의도치맥왕',
    text:'치킨 주문했어요! 빨리 오세요~ 🍗', timestamp: DateTime.now(),
    isMe: false),
  ChatMessage(id:'m2', senderId:'me', senderNickname:'나',
    text:'오 좋아요! 어디서 만날까요?', timestamp: DateTime.now(),
    isMe: true),
  // ...
];
```

### screens/matching/matching_screen.dart
전면 개편:

```
구조:
PurpleScaffold(
  headerChild: Column(
    - 페이지 타이틀 "매칭"
    - 총 접속자 수 글래스 카드 ("현재 한강에 127명")
    - 지역 칩 (가로 스크롤 ListView)
    - 취미 칩 (가로 스크롤 ListView)
    - 모드 토글 ("같이 놀래요" / "혼자 있을래요")
  ),
  bodyChild: ListView.builder(
    - 필터된 사용자 리스트
    - 각 항목: ListTile(아바타, 닉네임+Lv, 거리+활동, 최근모임)
    - onTap → Navigator.push(UserProfileScreen)
  ),
)
```

### screens/chat/chat_list_screen.dart
전면 개편:

```
구조:
PurpleScaffold(
  headerChild: Row(뒤로가기, "모임방", FAB(+)),
  bodyChild: ListView.builder(
    items: mockRooms,
    각 항목:
      - 그라데이션 아이콘 + 제목 + 자물쇠/배지
      - 방장닉네임 · 지역 · (n/m명)
      - 공개+참여중 → onTap: Navigator.push(ChatRoomScreen)
      - 공개+미참여 → onTap: 바로입장 후 ChatRoomScreen
      - 비공개+미참여 → onTap: 아코디언 토글
        - 펼침: 방장 프로필 카드 + 손흔들기 버튼
  ),
  FAB: onTap → Navigator.push(CreateRoomScreen),
)
```

---

## 3. 신규 파일

### screens/profile/user_profile_screen.dart
타인 프로필 상세:

```
구조:
PurpleScaffold(
  headerChild: Column(
    - 아바타(60px) + 닉네임 + Lv배지 + 거리 + 활동
  ),
  bodyChild: Column(
    - 한줄 소개 인용 카드
    - 매너 태그 Wrap
    - 한강 온도 바
    - 최근 참여 모임
    - 연락처 단계 (Stage 1~4)
    - Row(다음에 버튼, 손흔들기 버튼)
  ),
)
```

### screens/chat/create_room_screen.dart
모집글 작성:

```
구조:
Scaffold(backgroundColor: white,
  appBar: X닫기 + "모집글 작성" + 등록 버튼,
  body: SingleChildScrollView(
    - TextFormField(제목)
    - TextFormField(내용, maxLines)
    - Divider
    - 지역 선택 칩 Wrap
    - 인원 스텝퍼 Row(-, 숫자, +)
    - 공개/비공개 SwitchListTile
    - Divider
    - 미션 선택 RadioListTile 목록
      - 'custom' 선택 시: 사진/음성/글 CheckboxListTile + 설명 TextField
    - 미션 시간 Slider (1~10분)
  ),
)
```

### screens/chat/chat_room_screen.dart
그룹 채팅방:

```
구조:
Scaffold(
  appBar: 뒤로가기 + 방 제목 + (n/m명) + 더보기,
  body: Column(
    - 미션 카드 (있을 때만): 아이콘+미션명+MissionTimerWidget+참여버튼
    - Expanded(ListView: 채팅 메시지)
    - 입력바: TextField + 전송 + 사진 + 미션추가
  ),
)
```

### widgets/mission_submit_sheet.dart
미션 제출 바텀시트:

```
showModalBottomSheet(
  Column(
    - 미션명 + 남은시간
    - 제출 타입별 위젯:
      - photo: 사진 선택 버튼 + 미리보기
      - voice: 녹음 버튼 + 파형
      - text: TextField
    - 제출 버튼
  ),
)
```

---

## 4. 삭제할 파일

### screens/mission/mission_screen.dart
- 독립 미션 탭 제거
- 타이머 로직은 widgets/mission_timer.dart로 이미 추출됨
- 미션 리스트/진행 UI는 chat_room_screen.dart에서 인라인으로 구현

---

## 5. 라우팅 변경 (main.dart 또는 routes.dart)

추가할 라우트:
```dart
'/user-profile': (context) => const UserProfileScreen(),
'/create-room': (context) => const CreateRoomScreen(),
'/chat-room': (context) => const ChatRoomScreen(),
```

---

## 6. 서버 스키마 변경 (server/prisma/schema.prisma)

### 변경: ChatRoom → 그룹 모임방
```prisma
model ChatRoom {
  id          String   @id @default(uuid())
  title       String
  description String?
  district    String   // 여의도, 뚝섬, 반포, 잠실, 망원, 이촌
  maxPeople   Int      @default(5)
  isPrivate   Boolean  @default(false)  // 기본 공개
  creatorId   String
  creator     User     @relation("RoomCreator", fields: [creatorId], references: [id])
  members     ChatRoomMember[]
  messages    ChatMessage[]
  missions    RoomMission[]
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}

model ChatRoomMember {
  id       String   @id @default(uuid())
  roomId   String
  userId   String
  role     String   @default("member") // creator, member
  joinedAt DateTime @default(now())
  room     ChatRoom @relation(fields: [roomId], references: [id])
  user     User     @relation(fields: [userId], references: [id])
  @@unique([roomId, userId])
}

model RoomMission {
  id              String   @id @default(uuid())
  roomId          String
  missionType     String   // selfie, find_unusual, share_story, share_today, voice_intro, custom
  title           String
  description     String?
  attachmentTypes String[] // ["photo", "voice", "text"]
  timerSec        Int      @default(180)
  status          String   @default("pending") // pending, active, completed
  room            ChatRoom @relation(fields: [roomId], references: [id])
  submissions     MissionSubmission[]
  createdAt       DateTime @default(now())
}

model MissionSubmission {
  id        String      @id @default(uuid())
  missionId String
  userId    String
  type      String      // photo, voice, text
  content   String      // URL or text
  mission   RoomMission @relation(fields: [missionId], references: [id])
  user      User        @relation(fields: [userId], references: [id])
  createdAt DateTime    @default(now())
}
```

### User 모델 추가 필드:
```prisma
model User {
  // 기존 필드...
  mood            String?   // play, alone
  hobbies         String[]
  interests       String[]
  recentMoimTitle  String?
  createdRooms    ChatRoom[]       @relation("RoomCreator")
  roomMembers     ChatRoomMember[]
  submissions     MissionSubmission[]
}
```

---

## 7. 서버 API 라우트 변경

### GET /api/matching/users
```
Query: ?district=여의도&hobby=치맥&mood=play
Response: { totalOnline: 127, users: [...] }
```

### 모임방 CRUD
```
GET    /api/rooms              — 목록 (필터: district, isJoined)
POST   /api/rooms              — 생성 (title, description, district, maxPeople, isPrivate, mission)
GET    /api/rooms/:id          — 상세
POST   /api/rooms/:id/join     — 공개방 바로 입장
POST   /api/rooms/:id/wave     — 비공개방 손흔들기
POST   /api/rooms/:id/accept   — 방장이 손흔들기 수락
DELETE /api/rooms/:id/leave    — 나가기
```

### 미션
```
POST   /api/rooms/:id/missions          — 미션 추가 (방장)
PATCH  /api/rooms/:id/missions/:mid     — 미션 상태 변경 (start/complete)
POST   /api/rooms/:id/missions/:mid/submit — 미션 제출
```

### Socket.io 이벤트
```
room:join        — 입장 알림
room:leave       — 퇴장 알림
room:wave        — 손흔들기 알림 (방장에게)
room:accepted    — 수락 알림 (요청자에게)
mission:start    — 미션 시작 (전체)
mission:submit   — 미션 제출 (전체)
mission:complete — 미션 완료 (전체)
chat:message     — 채팅 메시지 (전체)
```

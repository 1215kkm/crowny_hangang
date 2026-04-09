/// API 서비스 — 서버 연결 레이어
///
/// Mock 단계에서는 MockData를 반환하고,
/// 실제 배포 시 HTTP 호출로 교체.
class ApiService {
  ApiService._();

  // 서버 URL (카페24 VPS 배포 후 변경)
  static const String baseUrl = 'http://localhost:3000/api';

  // ── Auth ──
  // POST /api/auth/register
  // POST /api/auth/verify

  // ── Users ──
  // GET  /api/users?district=여의도&mood=play
  // GET  /api/users/:id
  // PATCH /api/users/:id (프로필 수정)
  // POST /api/users/:id/trust-vote (신뢰도 투표)

  // ── Matching ──
  // GET  /api/matching/users?district=&hobby=&mood=
  // POST /api/matching/wave (손흔들기)

  // ── Rooms ──
  // GET  /api/rooms (모임방 목록)
  // POST /api/rooms (모임방 생성)
  // POST /api/rooms/:id/join (입장)
  // POST /api/rooms/:id/wave (비공개방 손흔들기)
  // DELETE /api/rooms/:id/leave (나가기)

  // ── Chat ──
  // GET  /api/rooms/:id/messages (메시지 목록)
  // POST /api/rooms/:id/messages (메시지 전송)
  // GET  /api/dm (DM 목록)
  // POST /api/dm (DM 생성)
  // GET  /api/dm/:id/messages (DM 메시지)

  // ── Board ──
  // GET  /api/board?district=&category=
  // POST /api/board (게시글 작성)
  // GET  /api/board/:id (게시글 상세)
  // POST /api/board/:id/comments (댓글)
  // POST /api/board/:id/like (좋아요)

  // ── Games ──
  // POST /api/rooms/:id/games (게임 시작 → Socket.io로 전파)
  // POST /api/rooms/:id/games/:gameId/submit (답변/제출)

  // ── Location ──
  // POST /api/rooms/:id/location (위치 공유 시작)
  // DELETE /api/rooms/:id/location (위치 공유 종료)
  // → Socket.io: location:update, location:stop

  /// TODO: 실제 HTTP 호출 구현
  /// ```dart
  /// static Future<List<MoimRoom>> getRooms() async {
  ///   final res = await http.get(Uri.parse('$baseUrl/rooms'));
  ///   final list = jsonDecode(res.body) as List;
  ///   return list.map((j) => MoimRoom.fromJson(j)).toList();
  /// }
  /// ```
}

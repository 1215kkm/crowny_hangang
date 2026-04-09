# 크라우니 한강 (Crowny Hangang) - 종합 기획서

## Context
한강을 중심으로 국내 이용자와 외국 관광객이 오프라인에서 자연스럽게 연결되는 커뮤니티 앱.
기존 커뮤니티의 "만나기 전 불안 + 만난 후 연결 단절" 문제를 해결하고,
특히 **분위기 어색함 해결 시스템(섹션 5)**을 완전히 새로 설계한다.

---

## 1. 프로젝트 개요

### 핵심 컨셉
- "한강에서의 우연한 만남을 설계된 우연(Engineered Serendipity)으로"
- **이미 같은 물리적 공간에 있는 사람들**을 연결 (온→오프가 아닌 오프 우선)
- 한강 공원 11개 지구 커버, 각 지구별 특색 반영

### 왜 한강인가
- **개방 공간 효과**: 넓은 야외 → 심리적 경계 낮아짐
- **병행 활동 환경**: 치맥/피크닉/자전거 등 이미 활동 중 → "만남이 목적"이라는 부담 감소
- **시간적 한정성**: 2-4시간 나들이 → 자연스러운 종료 시점 존재
- **한국 특유의 한강 문화**: 배달, 치맥, 라면 등 이미 익숙한 사회적 활동 공간

### 경쟁 분석
| 서비스 | 차이점 |
|--------|--------|
| 소모임/문토 | 사전 기획 모임 vs 우리는 즉흥+현장 기반 |
| 위피/아자르 | 온라인 중심 vs 우리는 오프라인 우선 |
| Meetup | 관심사 그룹 vs 우리는 위치+시간 기반 즉석 매칭 |

---

## 2. 타겟 사용자

### 1차: 한강 단골 (20-30대 서울 거주자)
- 페르소나 A: 퇴근 후 한강 러닝하는 28세 직장인. 러닝 메이트 찾고 싶지만 동호회는 부담
- 페르소나 B: 주말 한강 피크닉 좋아하는 25세 대학생. 새 사람 만나고 싶지만 소개팅은 싫음

### 2차: 외국인 관광객/거주자
- 페르소나 C: 한강 치맥 해보고 싶은 일본인 여행자. 혼자는 재미없음
- 페르소나 D: 한국인 친구 만들고 싶은 이태원 거주 미국인

### 3차: 이벤트/활동 기반
- 버스킹 관객, 자전거/러닝 동호회원, 반려동물 산책자

---

## 3. 주요 기능 설계

### 3.1 실시간 한강 매칭
- **위치 정책**: 누구나 모든 기능 사용 가능. 한강 반경 2km 이내 사용자는 닉네임 옆에 "한강근처" 배지 자동 표시. 한강근처 사용자끼리 우선 매칭.
- **활동 기반 매칭**: 위치 + "지금 하고 있는 것" 기준 (치맥/러닝/산책/펫 등)
- **그룹 사이즈 매칭**: 1:1, 소그룹(3-5), 합류형
- **"손 흔들기"**: 매칭 요청 전 가볍게 관심 표현
- **"마감 임박" 매칭**: "30분 후 갈 건데, 지금 잠깐 놀 사람!"
- **거절 부담 최소화**: "지금은 바빠요" 자동 응답 (거절이 아닌 타이밍 프레임)
- **날씨/일몰 연동**: "오늘 일몰 7시 23분, 반포대교 야경 같이 볼 사람?"

### 3.2 신뢰 시스템
- **인증 5단계**: 전화번호 → 본인인증(PASS) → 프로필사진 AI검증 → 첫 만남 완료 → "한강 단골" 배지
- **매너 태그**: 별점 대신 구체적 태그 ("시간 약속 잘 지켜요", "분위기 메이커예요")
- **상호 리뷰 잠금**: 양쪽 모두 작성해야 열람 가능 (편향 방지)

### 3.3 안전 기능
- 실시간 위치 공유 (가족/친구에게, 옵트인)
- 긴급 신고 원터치 → 112 연동 + GPS 자동 전송
- AI 이상 행동/언어 감지
- 타임아웃 체크인: 1시간 후 "괜찮으세요?" → 미응답 시 비상연락처 알림

### 3.4 연락처 던지기 (4단계 점진적 공개)
- Stage 1: 한강 닉네임 ("뚝섬치맥러")
- Stage 2: 앱 내 채팅 + 음성 메시지 (익명 유지)
- Stage 3: 카카오/인스타/전화번호 택1 (상호 동의 필수)
- Stage 4: 직업, 관심사, 실명 등 상세 프로필

**UX 포인트:**
- 연락처 공개 시 카카오톡 자동 연결 (별도 교환 과정 불필요)
- **주 1회 별명 변경 가능**: 새로운 만남을 위한 리프레시. 과거 인연에 얽매이지 않는 구조

### 3.5 만남 이후 UX
- "한강 추억" 타임라인 (날짜, 장소, 사람, 날씨) — 본인만 열람
- 재회 넛지 (3일/7일/14일 후) — 상대방이 원할 때만 자연스럽게
- **"새 사람 우선" 매칭**: 기본적으로 이전에 만난 사람보다 새로운 사람을 우선 매칭
- **주 1회 별명 변경**: 새로운 시작이 가능한 구조. 같은 사람이 알아보지 못하게 리프레시

### 3.6 외국인 지원
- DeepL/GPT 기반 실시간 번역 채팅
- "언어 교환" 모드 매칭
- 문화 브릿지 카드 (한강 라면 문화, 치맥 문화 설명)
- "K-체험" 가이드 매칭

### 3.7 이벤트/모임
- 번개(즉흥), 정기, 시즌, 테마, 브랜드 협업 이벤트
- 3단계 RSVP: 확정 / 관심 있음 / 근처에 있으면 갈게
- 최소 인원 보장 시스템 ("5명 이상 모이면 확정!")

---

## 4. 분위기 어색함 해결 시스템 (완전 재설계)

> **설계 철학**: 어색함은 "제거"가 아니라 "변환". 어색한 에너지를 재미/호기심/공동 과제의 에너지로 전환.

### 어색함의 6가지 원인과 솔루션 매핑

| 원인 | 솔루션 | 시스템 |
|------|--------|--------|
| 첫 마디를 못 꺼내겠다 | 미션이 대화 소재 제공 | 4.1 미션 타이머 |
| 나를 이상하게 볼까 봐 | "미션이 시켜서요" = 핑계 | 4.1 미션 타이머 |
| 대화가 끊겼다 | AI가 자연스러운 화제 투입 | 4.2 분위기 카드 |
| 뭘 같이 해야 할지 모르겠다 | 공동 목표/스탬프 | 4.3 공동 목표 |
| 어떻게 행동해야 할지 모르겠다 | 구체적 역할 부여 | 4.4 역할 시스템 |
| 언제 헤어져야 할지 모르겠다 | 타이머 + 연장 투표 | 4.7 자연스러운 이별 |

### 4.1 한강 미션 타이머 (핵심 - 사용자 아이디어 기반)

**아키텍처**: 미션은 코드에 하드코딩하지 않고 **JSON 데이터로 관리**
→ 서버 JSON 수정만으로 앱 업데이트 없이 미션 추가/수정/삭제 가능
→ 관리자 페이지에서 CRUD 가능
→ 시즌/지역/난이도/언어별 필터링 지원
→ 새 미션 타입(photo, quiz, vote 등) 추가 시에만 코드 수정 필요

**원리**: 시간 압박이 "핑계"를 제공 → "내가 적극적인 게 아니라 미션이 시켜서" (외적 귀인 심리)

**Phase 1: 워밍업 (0-5분)**
- "서로 닉네임과 오늘 한강 온 이유 공유" (2분)
- "상대방과 공통점 3개 찾기" (3분)

**Phase 2: 액티비티 (5-15분)**
- "한강 배경 가장 웃긴 셀카 찍기" (3분)
- "주변에서 가장 특이한 것 찾아서 보여주기" (5분)
- "지나가는 사람에게 사진 찍어달라고 부탁" (3분)

**Phase 3: 대화 심화 (15-30분)**
- "최근 가장 감동/웃긴 일 공유" (5분)
- "서로에게 한강 음식 추천" (5분)

**Phase 4: 보너스 (선택)**
- "오늘 만남 한 문장 요약" (2분)
- "다음에 같이 하고 싶은 것 제안" (3분)

**UX:**
- 한강 물결 모양 타이머 애니메이션
- 미션 스킵 가능 (강제성 없음)
- 난이도 선택: 가벼운 / 보통 / 모험적
- 시즌별/지구별 특화 미션

### 4.2 분위기 전환 카드 (AI 기반)
- 수동/반자동 발동
- **카드 유형**: "이거 알아요?"(한강 퀴즈), "이런 건 어때요?"(근처 활동 추천), "솔직히 말하면"(자기 개방), "갑자기 퀴즈"
- 외국인 특화: "한국어 한 마디" 카드, "우리나라에서는" 카드

### 4.3 공동 목표 시스템
- **한강 스탬프 랠리**: 함께 미션 완료 → 스탬프 수집 → "한강 메이트" 뱃지
- **한강 탐험대**: 3-5명 팀 미션 수행 (1:1보다 어색함 적음)

### 4.4 역할 부여
- "한강 가이드/탐험가", "치맥 감독/신입", "사진사/모델"
- 역할이 명확하면 행동 불안 감소 + 대화 소재 자동 생성

### 4.5 환경 활용
- 일몰 알림 + 대화 프롬프트
- 음식 매개: "편의점에서 서로를 위한 음식 골라오기"
- **"치맥 모드"**: 치킨 주문 단계부터 함께 → "뭐 시킬까요?"가 자연스러운 첫 대화
- 비음주 옵션: 카페/디저트 중심 매칭

### 4.6 그라데이션 참여 (수줍은 사람용)
1. "조용히 같이 있기" - 대화 없이 같은 공간. 내향적인 사람도 OK
2. "가볍게 대화" - 미션 없이 자연스럽게
3. "미션 모드" - 타이머 미션 활용
4. "모험 모드" - 과감한 미션 + 즉흥 활동

실시간 모드 전환 가능 ("에너지 떨어졌어" → 모드 다운)

### 4.7 자연스러운 이별 시스템
- **한강 타임아웃**: 매칭 시 예상 시간 설정 → 시간 되면 앱이 알림
- **연장 투표**: 양쪽 "더 놀래요" → 연장. 한쪽만 → "다음에!" 자동 메시지 (거절 부담 앱이 대신)
- **마무리 미션**: "오늘 한 줄 감상" 교환

### 4.8 게이미피케이션 (성인 친화적)
- **"한강 온도"**: 만남 횟수 + 리뷰 기반. 36.5도 기본, 올라갈수록 "따뜻한 사람"
- **"한강 스토리"**: 만남 기록 타임라인 → 수집 욕구
- 숨겨진 업적: "비 오는 날 만남" = "우천 우정" 배지

### 4.9 크로스컬처 특화
- **Culture Cheat Sheet**: 매칭 전 상대 문화 간단 가이드
- **번역 SOS 버튼**: 즉시 번역 지원
- **"같이 배우기"**: 한국어/영어 단어 3개씩 가르치기 미션

---

## 5. 수익 모델

### 핵심 전략: 앱 사용은 완전 무료 → 커머스 수수료
- 초기: 모든 기능 무료 (사용자 확보 집중)
- 나중에: 한강에서의 주문/배달 중개 수수료 (5~15%)
  - 배달 음식 주문 (치킨, 피자 등)
  - 편의점 픽업 주문
  - 선물하기 (음료, 간식 등)
  - "같이 먹을 치킨 주문" 같은 맥락으로 자연스러운 연결
- **구현 전략**: 커머스 기능은 MVP부터 코드에 포함하되, UI에서 숨김 처리. 필요 시 서버 설정으로 노출

### 보조 수익 (나중에)
- 프리미엄 매칭 (우선 노출, 무제한 손흔들기)
- 브랜드 협업 이벤트 (MAU 5만+ 이후)

---

## 6. 기술 스택

### 서버: 카페24 VPS 호스팅 (고정비, 자체 관리)
- **Frontend**: Flutter (iOS/Android)
- **Backend**: Node.js (Express or NestJS) — 카페24 VPS에 배포
- **DB**: PostgreSQL + PostGIS (위치 기반 쿼리 네이티브 지원)
- **캐시/세션**: Redis
- **실시간**: Socket.io (채팅, 매칭 알림, 미션 동기화)
- **인증**: Firebase Auth (무료 — 카카오/구글/Apple 로그인)
- **푸시 알림**: FCM (무료 무제한)
- **파일 저장**: 카페24 스토리지 or Cloudflare R2 (10GB 무료)
- **지도**: Kakao Maps API (무료)
- **번역**: Google Cloud Translation (월 50만 자 무료)

### 카페24 VPS 예상 비용
- 플랜: 리눅스 VPS (2코어/4GB RAM) — 약 월 ₩11,000~₩22,000
- DB, 백엔드, Redis 모두 한 서버에서 운영 가능 (초기)
- 고정비라 비용 예측 쉬움 (Firebase 종량제 대비 장점)

### Firebase와의 역할 분담
- Firebase: 인증(Auth) + 푸시(FCM)만 사용 (둘 다 무료)
- 나머지 전부: 카페24 자체 서버
- **실시간**: Firestore 실시간 리스너 + Cloud Functions
- **지도**: Kakao Maps API
- **번역**: DeepL API + GPT
- **인증**: Firebase Auth + PASS 앱 연동

### Firebase 읽기/쓰기 전략 (비용 최적화 핵심)

#### 폴링 vs onSnapshot 구분

**onSnapshot (실시간 리스너) 사용 - 화면 열 때만:**
- 채팅 메시지 (채팅 화면 열 때 시작, 닫을 때 정지)
- 매칭 알림 (매칭 화면 열 때 시작)
- 미션 타이머 동기화 (미션 화면 열 때만)

**폴링 방식 사용:**
- 근처 사용자 탐색 (30초~1분 간격 폴링)
  - 위치 업데이트: 사용자가 앱을 열고 있을 때만 GPS 위치를 Firestore에 기록
  - 근처 사용자 조회: Geohash 기반 쿼리로 반경 500m 내 사용자 폴링
  - 앱이 백그라운드로 가면 폴링 중지
- 번개 모임 목록 (1분 간격)
- 이벤트 목록 (사용자 수동 새로고침 or 1분 폴링)

#### onSnapshot 생명주기 관리 (필수)
```
규칙: "화면 열 때 시작, 닫을 때 정지"
- 화면 진입 (initState/onResume) → listener 등록
- 화면 이탈 (dispose/onPause) → listener.cancel()
- 앱 백그라운드 → 모든 listener 일시 정지
- 앱 포그라운드 → 현재 화면의 listener만 재개
```
이렇게 안 하면 사용자가 보고 있지 않아도 읽기가 계속 발생 → Firebase 비용 폭탄

#### Firestore 비용 절감 전략
- 문서 크기 최소화 (필요한 필드만)
- 캐시 우선 정책 (Firestore offline persistence)
- 쿼리 결과 로컬 캐시 + TTL
- 읽기 빈도가 높은 데이터는 Cloud Functions에서 집계 후 단일 문서로 제공

---

## 7. MVP 로드맵

### Phase 1 (MVP - 2개월)
- 위치 기반 사용자 탐색 + 기본 매칭
- 앱 내 채팅
- 미션 타이머 (기본 미션 20개)
- 기본 프로필 + 신뢰 레벨

### Phase 2 (3-4개월)
- 연락처 던지기, 분위기 카드, 외국인 지원
- 리뷰/매너 태그, 이벤트 기능

### Phase 3 (5-6개월)
- AI 매칭 고도화, 업적 시스템
- 브랜드 협업, 프리미엄 구독

---

## 8. 런칭 전략
- **시점**: 4월 초 (벚꽃 시즌)
- **Pre-launch**: 한강 앰배서더 100명 + 대학교 타겟 (서강/홍대/연세/한양)
- **바이럴**: 만남 후 "한강 카드" SNS 공유 (인스타 스토리 최적화)
- **확장**: 한강 → 해운대/수성못 → 도쿄 스미다강/파리 센강

---

## 9. 검증 방법
- 미션 완료율 60%+, 미션 스킵률 30% 이하
- 매칭 성사율 40%+, 실제 만남 전환율 70%+
- 만남 후 "어색하지 않았다" 응답률 80%+
- 재만남률 25%+

---

## 대규모 구조 변경 계획

### Context
기존 앱은 UI 껍데기 위주. 이번 변경으로 실제 앱 흐름을 완성:
- 미션 탭 제거 → 채팅방(모임방) 안에서 미션 수행
- 매칭을 필터 기반 사용자 탐색으로 개편
- 채팅을 그룹 모임방 시스템으로 전환
- 프로필 상세보기 + 모집글 작성 추가

### 모임방 입장 방식
- **기본: 공개방** (누구나 바로 입장)
- **방장이 비공개 선택 시**: 자물쇠 표시, 손흔들기 → 방장 수락 → 입장

### 변경/생성 파일 목록

#### HTML (crowny-app.html)
| 작업 | 내용 |
|------|------|
| 네비 | 미션 탭 제거 → 4탭 |
| #page-mission | 삭제 (CSS는 유지, 채팅방 미션에 재사용) |
| #page-matching | 전면 개편: 총 접속자 수 + 필터(지역/취미/관심사/놀래요·혼자) + 사용자 리스트 + 각 사용자 최근 모임 표시 |
| #page-chat | 전면 개편: 모임방 목록 (자물쇠/배지/인원수) + 상세보기 펼침 + 모집글 작성 |
| 신규 #page-user-profile | 상대 프로필 상세 (공개 단계별) |
| 신규 #page-create-room | 모집글 작성 (제목/내용/지역/인원/미션선택) |
| 신규 #page-chat-room | 그룹 채팅방 + 인라인 미션 타이머 + 미션 제출 |

#### Flutter 수정
| 파일 | 변경 |
|------|------|
| `widgets/crowny_bottom_nav.dart` | 5→4탭 (미션 제거) |
| `screens/main_shell.dart` | MissionScreen 제거, IndexedStack 4개 |
| `screens/matching/matching_screen.dart` | 전면 개편: 필터+리스트 |
| `screens/chat/chat_list_screen.dart` | 전면 개편: 모임방 목록 |
| `models/chat_model.dart` | ChatRoom→MoimRoom, RoomMission, MissionSubmission 추가 |
| `models/user_model.dart` | mood, hobbies, interests, recentMoimTitle 추가 |
| `models/mission_model.dart` | RoomMission, MissionSubmission 추가 |
| `mock/mock_data.dart` | 모임방/필터 데이터로 교체 |

#### Flutter 신규
| 파일 | 용도 |
|------|------|
| `screens/profile/user_profile_screen.dart` | 타인 프로필 (공개 단계별 표시) |
| `screens/chat/chat_room_screen.dart` | 그룹 채팅방 + 미션 |
| `screens/chat/create_room_screen.dart` | 모집글 작성 |
| `widgets/mission_timer.dart` | 타이머 위젯 추출 (재사용) |
| `widgets/mission_submit_sheet.dart` | 미션 제출 바텀시트 (사진/음성/텍스트) |

#### Flutter 삭제
| 파일 | 이유 |
|------|------|
| `screens/mission/mission_screen.dart` | 독립 탭 제거 (위젯 추출 후) |

#### 서버 (server/)
| 파일 | 변경 |
|------|------|
| `prisma/schema.prisma` | ChatRoom→그룹방, ChatRoomMember, RoomMission, MissionSubmission 추가 |
| `src/routes/chat.js` | 모임방 CRUD + 손흔들기 입장 요청 |
| `src/routes/matching.js` | 필터 기반 사용자 조회 + 총 접속자 수 |
| `src/routes/users.js` | 프로필 상세 (공개 단계 필터링) |
| `src/routes/missions.js` | 방 내 미션 CRUD + 제출 |
| `src/socket/handler.js` | room:wave, mission:start/submit 이벤트 |

### 핵심 기능 흐름

```
매칭 탭 → 필터로 사람 탐색 → 프로필 상세보기
      ↓
채팅(모임) 탭 → 모임방 목록
  ├─ 열린 방(참여중) → 탭 → 그룹 채팅 + 미션 참여
  └─ 자물쇠 방(미참여) → 탭 → 상세보기(방장 프로필+미션) → 손흔들기 → 방장 수락 → 입장
      ↓
모집글 작성 (FAB) → 제목/내용/지역/인원/미션 선택 → 등록
      ↓
방 안에서 미션 → 타이머 시작 → 사진/음성/텍스트 제출 → 채팅에 결과 전송
```

### 미션 타입
| 미션 | 제출 방식 |
|------|----------|
| 가장 웃긴 셀카 | 사진 업로드 |
| 주변 특이한 것 찾기 | 사진 업로드 |
| 감동/웃긴 일 공유 | 텍스트 |
| 오늘 일 공유 | 텍스트 |
| 본인 소개 | 10초 음성 녹음 |
| 방장 직접 정하기 | 사진/음성/글 중 다중선택 |

### 구현 순서
1. **crowny-app.html** 먼저 (바로 확인 가능)
2. Flutter 모델 + Mock 데이터
3. Flutter 위젯 (타이머 추출, 바텀시트)
4. Flutter 화면 (매칭→채팅→프로필→모집글→채팅방)
5. 서버 스키마 + API

### 검증
- crowny-app.html → 브라우저에서 모든 페이지 전환 확인
- 자물쇠 방 탭 → 상세보기 펼침 → 손흔들기 동작 확인
- 모집글 작성 → 폼 입력 → 등록 확인
- 매칭 필터 → 리스트 변경 확인
- 기존 v1~v3 HTML 파일은 참고용으로 보존

---

## 구현 계획 (카페24 VPS + Flutter)

### Step 0: 백엔드 서버 구축 (카페24 VPS)
```
server/
├── src/
│   ├── app.js               — Express 앱 초기화
│   ├── routes/
│   │   ├── auth.js           — 인증 (Firebase Auth 토큰 검증)
│   │   ├── users.js          — 사용자 CRUD, 위치 업데이트
│   │   ├── matching.js       — 매칭/손흔들기
│   │   ├── missions.js       — 미션 타이머
│   │   ├── chat.js           — 채팅 메시지
│   │   ├── events.js         — 이벤트/번개 모임
│   │   └── commerce.js       — 커머스 (숨김 상태로 준비)
│   ├── models/               — PostgreSQL 모델 (Sequelize or Prisma)
│   ├── socket/               — Socket.io 실시간 핸들러
│   ├── middleware/            — 인증, 에러 핸들링
│   └── config/               — DB, Redis, Firebase 설정
├── package.json
└── .env
```

### Step 1: 슈퍼 관리자 - 디자인 관리 페이지

**목표**: 관리자가 앱의 모든 화면 디자인을 웹에서 관리/수정할 수 있는 시스템.

#### 파일 구조
```
admin/
├── index.html              — 관리자 대시보드 (사이드바 + 라우팅)
├── css/
│   ├── admin.css           — 관리자 페이지 자체 스타일
│   └── design-tokens.css   — 글로벌 디자인 변수 (CSS Custom Properties)
├── js/
│   ├── app.js              — SPA 라우팅 + 초기화
│   ├── design-manager.js   — 글로벌/개별 디자인 변수 관리 로직
│   ├── lang-manager.js     — 다국어 텍스트 로딩/관리
│   └── image-manager.js    — 아이콘/배경 이미지 업로드 관리
├── lang/
│   ├── ko.json             — 한국어 텍스트
│   ├── en.json             — 영어 텍스트
│   └── ja.json             — 일본어 텍스트
├── screens/                — 앱 화면 HTML 목업들 (모바일 프리뷰)
│   ├── splash.html
│   ├── home.html
│   ├── matching.html
│   ├── mission-timer.html
│   ├── chat.html
│   ├── profile.html
│   └── event.html
└── assets/                 — 업로드된 이미지/아이콘
```

#### 핵심 기능 구현

**1. 글로벌 디자인 변수 시스템 (design-tokens.css)**
CSS Custom Properties로 모든 디자인 토큰 관리:
- `--color-primary`, `--color-secondary`, `--color-accent` (메인/서브/보조 색상)
- `--font-family`, `--font-size-h1` ~ `--font-size-body` (계층별 글자크기)
- `--shadow-sm`, `--shadow-md`, `--shadow-lg` (그림자 스타일)
- `--btn-hover-color`, `--btn-active-color` (버튼 상태 색상)
- `--border-radius-sm`, `--border-radius-md`, `--border-radius-lg`
- `--spacing-section`, `--spacing-element` (섹션별 여백)

**2. 디자인 관리 페이지 (메인)**
- 좌측: 글로벌 디자인 설정 패널 (색상 피커, 슬라이더, 폰트 선택 등)
- 우측: 모든 앱 화면을 **그리드(카드형)**로 표시 (2-3열)
- 각 화면 카드: 미니 프리뷰 + 이름 + [글로벌/개별] 토글 스위치
- 카드 클릭 → 해당 화면 상세 편집 모드 진입

**3. 개별 화면 편집**
- 각 화면마다 [글로벌 디자인 적용 / 개별 디자인 설정] 체크박스
- 개별 선택 시: 해당 화면만의 디자인 변수 오버라이드 가능
- 모바일 프리뷰 (375px iframe) + 실시간 반영

**4. 다국어 텍스트 관리**
- 모든 화면 텍스트는 `data-lang-key="key_name"` 속성으로 바인딩
- lang/ko.json, en.json, ja.json에서 텍스트 로딩
- 관리자 페이지에서 언어별 텍스트 편집 가능

**5. 이미지 관리**
- 아이콘/배경 이미지 업로드 → assets/ 폴더 저장
- 드래그앤드롭 또는 파일 선택으로 교체
- 프리뷰에서 즉시 반영

#### 구현 순서
1. `admin/css/design-tokens.css` — 글로벌 CSS 변수 정의
2. `admin/lang/ko.json`, `admin/lang/en.json` — 다국어 텍스트 데이터
3. `admin/screens/*.html` — 7개 앱 화면 HTML 목업 (모바일 UI)
4. `admin/index.html` — 관리자 대시보드 + 디자인 관리 그리드 뷰
5. `admin/js/*.js` — 디자인 변수 관리, 언어 관리, 이미지 관리 로직
6. `admin/css/admin.css` — 관리자 페이지 스타일

#### 검증 방법
- 브라우저에서 `admin/index.html` 열기
- 글로벌 색상 변경 → 모든 화면 프리뷰에 즉시 반영 확인
- 개별 화면 "개별 디자인" 체크 → 해당 화면만 변경 확인
- 언어 전환 → 모든 텍스트 변경 확인
- 이미지 업로드 → 프리뷰 반영 확인

### Step 2: Flutter 앱 화면 (Mock 데이터, 현재 단계) ⬅️
**Style D 디자인 적용, 백엔드 없이 화면 먼저 완성**
**환경: Flutter SDK 미설치 → 코드 파일 작성 후 로컬에서 빌드**

구현 순서:
1. `flutter/pubspec.yaml` + 프로젝트 기본 구조
2. `lib/app/theme.dart` — Style D 디자인 토큰 (색상, 폰트, 그림자 등)
3. `lib/app/routes.dart` — 라우팅
4. `lib/mock/` — Mock 데이터 (사용자, 미션, 이벤트)
5. `lib/models/` — 데이터 모델
6. `lib/widgets/` — 공통 위젯 (바텀시트, 네비게이션, 카드 등)
7. 화면 순서:
   a. 스플래시 + 로그인
   b. 홈 (지도 + 사용자 + 활동 + 번개)
   c. 매칭 (프로필 카드 + 손흔들기)
   d. 미션 타이머 (JSON 데이터 드리븐)
   e. 채팅
   f. 프로필 (한강 온도, 매너태그, 연락처 단계)
   g. 이벤트/번개
   h. 설정
   i. 커머스 (숨김)

Flutter 프로젝트 구조:
```
lib/
├── main.dart
├── app/
│   ├── routes.dart
│   └── theme.dart            — Style D 디자인 토큰
├── screens/
│   ├── splash/
│   ├── auth/
│   ├── home/
│   ├── matching/
│   ├── mission/
│   ├── chat/
│   ├── profile/
│   ├── event/
│   ├── settings/
│   └── commerce/             — 숨김 상태
├── widgets/                   — 공통 위젯
├── models/                    — 데이터 모델
├── services/                  — API 서비스 (나중에 백엔드 연결)
├── mock/                      — Mock 데이터
└── l10n/                      — 다국어 (ko, en, ja)
```

### Step 3: 백엔드 API 서버 (Node.js + PostgreSQL)
- Express REST API + Socket.io
- PostgreSQL + PostGIS
- Firebase Auth 토큰 검증
- Redis 캐시

### Step 4: Flutter ↔ 백엔드 연결
- Mock 데이터 → 실제 API 호출로 교체
- 실시간 기능 연결 (채팅, 매칭 알림)

### Step 5: 카페24 VPS 배포
- Node.js + PostgreSQL + Redis 서버 세팅
- SSL 인증서 (Let's Encrypt 무료)
- PM2 프로세스 관리
- 자동 백업 설정

---

## v2.1 추가 변경 계획

### Context
v2 구조 변경 완료 후 추가 요구사항:
- 검색/1:1채팅/회원가입/게시판/프로필 등 미구현 기능 전체 구현
- 하단 네비 재구성 (게시판 추가, 프로필→햄버거)
- 햄버거 메뉴 + 한강 일러스트 지도

### 하단 네비 변경 (4탭)
```
Before: 홈 | 매칭 | 채팅 | 프로필
After:  홈 | 매칭 | 채팅 | 게시판
```
- 프로필은 햄버거 메뉴로 이동

### 변경 파일 목록 (구현 순서)

#### Phase 1: 네비 + 햄버거 메뉴 + 검색

**HTML (`app/crowny-app-v2.html`):**
| 작업 | 내용 |
|------|------|
| 하단 네비 | 프로필→게시판 변경 (forum 아이콘) |
| 사이드 드로어 | 좌측 슬라이드 메뉴 (로그인/회원가입/프로필/지도보기) |
| 검색 오버레이 | 검색창 + 채팅방/사용자 탭 + 결과 목록 |

**Flutter:**
| 파일 | 변경 |
|------|------|
| `widgets/crowny_bottom_nav.dart` | 프로필→게시판 탭 변경 |
| `screens/main_shell.dart` | Profile→BoardList, IndexedStack 4개 유지 |
| `screens/home/home_screen.dart` | 햄버거 → Drawer 열기, 검색 → SearchPage push |
| 신규 `widgets/app_drawer.dart` | 사이드 드로어 위젯 (메뉴 목록) |
| 신규 `screens/search/search_screen.dart` | 검색 화면 (채팅방/사용자 탭) |

#### Phase 2: 회원가입/로그인 (HTML)

**HTML:**
| 작업 | 내용 |
|------|------|
| 신규 #page-auth | 로그인 화면 (카카오/구글/Apple 소셜 버튼 + 이메일 로그인) |
| 신규 #page-signup | 회원가입 (닉네임/이메일/비밀번호 + 소셜 가입) |

**Flutter:** 이미 `screens/auth/auth_screen.dart` 완성됨 — 변경 없음

#### Phase 3: 1:1 채팅 + 채팅 필터

**HTML:**
| 작업 | 내용 |
|------|------|
| #page-chat 상단 | 3개 필터 아이콘 (전체/참여중/1:1) |
| 신규 #page-dm-room | 1:1 채팅방 |

**Flutter:**
| 파일 | 변경 |
|------|------|
| `screens/chat/chat_list_screen.dart` | 상단 3탭 필터 (전체/참여중/1:1) |
| 신규 `screens/chat/dm_room_screen.dart` | 1:1 채팅방 |
| `models/chat_model.dart` | DmRoom 모델 추가 |
| `mock/mock_data.dart` | DM mock 데이터 추가 |
| 프로필 상세 | "메시지 보내기" 버튼 추가 |

**Server:**
| 파일 | 변경 |
|------|------|
| 기존 `ChatRoom` 모델 | 이미 1:1 DM용으로 존재 (user1Id, user2Id) |
| `src/routes/chat.js` | DM 생성/목록/메시지 엔드포인트 |

#### Phase 4: 한강 게시판 (HTML) — 자유게시판 + 익명

**게시판 컨셉:**
- 여러 사람이 공유하는 **자유게시판**
- **익명 글쓰기 가능** (작성 시 "익명으로 쓰기" 토글)
- 익명 시 닉네임 대신 "익명" 표시
- 실명(별명) 게시 시 **게시판 전용 별명** 사용

**별명 시스템:**
- 가입 시 아이디(이메일)와 별도로 **게시판용 별명** 설정
- 프로필에 "게시판 별명" 칸 추가 (언제든 변경 가능)
- 채팅/매칭에서는 기존 닉네임 사용, 게시판에서만 별명 사용
- User 모델에 `boardNickname` 필드 추가

**HTML:**
| 작업 | 내용 |
|------|------|
| 신규 #page-board | 게시판 목록 (지역 필터 + 게시글 리스트, 익명 표시) |
| 신규 #page-board-detail | 게시글 상세 (댓글 + 익명 댓글 가능) |
| 신규 #page-board-write | 게시글 작성 (제목/내용/사진 + "익명으로 쓰기" 토글) |

**Flutter:** `screens/board/` 3개 파일에 익명 토글 + 별명 표시 추가

**Server:** `BoardPost`/`BoardComment`에 `isAnonymous` 필드, User에 `boardNickname` 추가

#### Phase 5: 프로필 기능 완성

**HTML & Flutter 공통:**
| 기능 | 내용 |
|------|------|
| 사진 등록 | 프로필 아바타 탭 → 파일 선택 (mock: 미리보기만) |
| 게시판 별명 | 프로필에 "게시판 별명" 칸 추가 (편집 가능) |
| 본인 신뢰도 | 숫자 + 프로그레스바 + "+받은 수 / -받은 수" 표시 |
| 내 배지 | 배지 목록 (획득/미획득 구분) |
| 활동 기록 | 참여한 모임 히스토리 리스트 |
| 관심 목록 | 즐겨찾기한 모임/사용자 |

#### Phase 6: 한강 일러스트 지도

**HTML & Flutter:**
| 작업 | 내용 |
|------|------|
| SVG 일러스트 지도 | 한강 물줄기 + 11개 지구 영역 (CSS/SVG) |
| 지구별 인원수 | 각 지구 위에 "여의도 12명" 배지 표시 |
| 탭 인터랙션 | 지구 탭 → 해당 지구 모임방 목록으로 이동 |

**일러스트 지도 구현 방식:**
- SVG viewBox로 한강 물줄기 + 강남/강북 영역 그리기
- 각 지구를 `<path>` 또는 `<rect>`로 표현 + 라벨
- CSS hover/tap 효과
- 지구별 접속자 수를 동적으로 표시
- 사용자 위치는 **지구 단위만** (프라이버시 보호)

### 검색 기능 상세

```
검색창 입력 → 디바운스 300ms → 결과 표시
├── 탭1: 채팅방 (모임방 이름 매칭)
│   └── 각 항목 탭 → 모임방 상세
└── 탭2: 사용자 (닉네임 매칭)
    └── 각 항목 탭 → 프로필 상세
```

### 채팅 상단 필터 아이콘

```
[📋 전체] [✅ 참여중] [💬 1:1]
```
- 전체: 모든 모임방 (기본)
- 참여중: isJoined=true인 모임방만
- 1:1: DM 목록

### 햄버거 드로어 메뉴

```
┌──────────────────┐
│  👤 프로필 사진    │
│  한강탐험가        │
│  신뢰도 78        │
├──────────────────┤
│  🔑 로그인        │ (비로그인 시)
│  📝 회원가입      │ (비로그인 시)
│  👤 프로필        │
│  🗺 한강 지도     │
│  ⚙️ 설정         │
├──────────────────┤
│  🚪 로그아웃      │
└──────────────────┘
```

### Mock 데이터 추가

```javascript
// DM 목록
dmRooms: [
  { id:'dm1', partner: users[0], lastMessage:'내일 뚝섬에서 봐요!', time:'19:30', unread:1 },
  { id:'dm2', partner: users[2], lastMessage:'사진 공유해주세요!', time:'어제', unread:0 },
]

// 지구별 접속자 수
districtOnline: {
  '여의도': 23, '뚝섬': 18, '반포': 15, '잠실': 12,
  '망원': 9, '이촌': 8, '난지': 7, '양화': 6,
  '선유도': 5, '광나루': 4, '암사': 3
}
```

### 검증
- 하단 네비: 게시판 탭 → 게시판 목록 표시 확인
- 햄버거: 메뉴 열기 → 프로필/지도/설정 이동 확인
- 검색: 채팅방/사용자 검색 + 결과 탭 전환 확인
- 1:1 채팅: DM 목록 → 대화방 진입 확인
- 게시판: 목록 → 상세 → 댓글 → 작성 확인
- 지도: 일러스트 지도 표시 + 지구 탭 인터랙션 확인
- 회원가입: 폼 입력 → 가입 → 로그인 흐름 확인

---

## v2.3 채팅방 게임 UX 개선

### Context
v2.2에서 채팅방 게임 16종을 구현했으나, 여러 UX 문제가 발견됨:
- 채팅방 헤더 레이아웃 문제 (제목 왼쪽 쏠림, 더보기 버튼 위치)
- 게임 닫기 시 사운드/타이머가 백그라운드에서 계속 실행
- 카운트다운 위치가 정가운데가 아님
- 게임별 설정 화면 필요 (눈치게임 시간, 역할배정 목록 등)
- 밸런스 게임 질문 부족 + 7문제 연속 + 궁합 결과 필요

### 수정 항목

#### 1. 채팅방 헤더 레이아웃 수정
**현재**: 뒤로가기 | 제목(flex:1) | 더보기 → 제목이 왼쪽으로 쏠림
**수정**: 제목을 text-align:center + 더보기를 position:absolute로 맨 오른쪽에
```css
.chatroom-header { position: relative; justify-content: center; }
/* 뒤로가기: position absolute left */
/* 제목: text-align center */
/* 더보기: position absolute right */
```
**파일**: `crowny-app-v2.html` 227줄 CSS + 708~714줄 HTML

#### 2. 게임 닫기 시 모든 타이머/인터벌 정리
**문제**: closeGame()이 overlay만 숨기고 setInterval들이 계속 실행됨
**수정**: 
- 전역 배열 `activeTimers = []`에 모든 setInterval/setTimeout ID 저장
- `closeGame()`에서 전부 clearInterval/clearTimeout
- `runShuffleAnimation()`의 shuffleInt, countInt도 등록
- 눈치게임, 초성게임의 타이머도 등록
**파일**: `crowny-app-v2.html` JS 1640~1678줄 (runShuffleAnimation, closeGame)

#### 3. 카운트다운 위치 정가운데로
**현재**: shuffle-area 안에 absolute로 넣어서 shuffle-area 기준 중앙
**수정**: shuffle-area 대신 game-overlay 자체에 중앙 배치
- 카운트다운 단계에서 shuffleArea를 숨기고 별도 #countdownDisplay를 game-overlay 중앙에 표시
- CSS: `position:absolute; top:50%; left:50%; transform:translate(-50%,-50%)`
**파일**: CSS 325줄, JS 1660~1674줄

#### 4. 게임 시작 전 5초 카운트다운 (공통)
**현재**: 설정 없이 바로 시작
**수정**: 설정이 필요한 게임들은 설정 화면 → "시작" 버튼 → 5초 카운트다운 → 게임 시작
- 설정 없는 게임 (랜덤순서, 랜덤질문): 바로 셔플+카운트다운
- 설정 있는 게임: 설정 화면 표시 → 시작 → 5초 카운트다운 → 진행
**파일**: JS 각 게임 함수

#### 5. 눈치 게임 — 시간 설정 추가
**현재**: 바로 시작, 시간 제한 없음
**수정**:
- 시작 전 설정 화면: 시간 선택 (10초/20초/30초/1분/3분) 칩
- "시작" 버튼 → 5초 카운트다운 → 게임 시작 + 선택한 시간 카운트다운
- 시간 끝나면 자동 종료 + 결과
**파일**: JS nunchiGame() 함수

#### 6. 밸런스 게임 — 7문제 연속 + 궁합 결과
**현재**: 1문제만, 질문 6개
**수정**:
- 질문 10개 이상으로 확대:
  ['치킨','피자'], ['산','바다'], ['여름','겨울'], ['아침형','저녁형'],
  ['강아지','고양이'], ['짜장','짬뽕'], ['민트초코 O','민트초코 X'],
  ['소주','맥주'], ['카페','편의점'], ['드라마','영화'],
  ['한강 낮','한강 밤'], ['자전거','러닝']
- 7문제 연속 진행 (매번 다른 질문, 중복 없이)
- 각 참여자별 답변 기록
- 7문제 후 결과: "🎯 #1과 #3이 5/7 일치! 궁합 71%"
- 가장 많이 같은 답을 한 쌍 하이라이트
**파일**: JS balanceGame(), BALANCE_QS, voteBalance()

#### 7. 역할 배정 — 방장이 직접 입력
**현재**: 하드코딩된 4개 역할
**수정**:
- 설정 화면: 인원수(ROOM_MEMBERS.length)만큼 역할 이름 입력 칸
- 기본값으로 프리셋 제공 (치맥팟 등)
- "시작" → 5초 카운트다운 → 랜덤 배정 결과
**파일**: JS roleAssign()

#### 8. 자리 정하기 — 남녀 섞기 옵션
**현재**: 완전 랜덤
**수정**:
- 설정 화면: "랜덤 섞기" / "남녀 교대로 섞기" 선택
- 남녀 교대: ROOM_MEMBERS에 gender 필드 추가 (Mock)
- "시작" → 5초 카운트다운 → 배치 결과
**파일**: JS seatShuffle(), ROOM_MEMBERS에 gender 추가

### 수정 파일 목록

| 파일 | 수정 내용 |
|------|-----------|
| `crowny-app-v2.html` CSS (227~229줄) | chatroom-header 레이아웃 수정 |
| `crowny-app-v2.html` CSS (320~331줄) | 카운트다운 위치 수정, 설정화면 스타일 |
| `crowny-app-v2.html` HTML (708~714줄) | 채팅방 헤더 구조 변경 |
| `crowny-app-v2.html` JS closeGame() | 타이머 정리 로직 |
| `crowny-app-v2.html` JS runShuffleAnimation() | 카운트다운 위치 수정 |
| `crowny-app-v2.html` JS nunchiGame() | 시간 설정 + 카운트다운 추가 |
| `crowny-app-v2.html` JS balanceGame() | 7문제 연속 + 궁합 결과 |
| `crowny-app-v2.html` JS roleAssign() | 직접 입력 설정 화면 |
| `crowny-app-v2.html` JS seatShuffle() | 남녀 옵션 설정 화면 |
| `crowny-app-v2.html` JS BALANCE_QS | 12개로 확대 |
| `crowny-app-v2.html` JS ROOM_MEMBERS | gender 필드 추가 |

### 검증
- 채팅방 헤더: 제목 가운데, 더보기 맨 오른쪽
- 게임 닫기: 닫기 후 사운드/타이머 완전 정지 확인
- 카운트다운: 화면 정가운데에 5,4,3,2,1 표시
- 눈치게임: 시간 선택 → 시작 → 5초 카운트다운 → 게임
- 밸런스: 7문제 연속 → 궁합 결과 ("#1과 #3이 5/7 일치!")
- 역할배정: 역할 직접 입력 → 시작 → 배정 결과
- 자리정하기: 남녀 옵션 → 결과

### Context
채팅방에서 실제 만남을 돕는 실용적 기능들이 부족함.
위치 공유, 순서 정하기, 투표 등 오프라인 모임에 필요한 도구를 채팅방 안에 내장.

### 추가 기능 목록

#### 1. 위치 공유 (채팅방 + DM) — 실시간 슬라이드 지도
- 채팅 입력바의 `+` 버튼 탭 → 메뉴에 "위치 공유" 추가
- **공유 시작 시**:
  - 채팅방 오른쪽 밖에 미니 지도 패널이 숨겨져 있음 (transform: translateX(100%))
  - 화면 오른쪽에 **플로팅 버튼** (📍 아이콘, 보라색 원형) 이 항상 표시됨
  - 플로팅 버튼이 보이면 = 위치 공유 중이라는 것을 인지 가능
- **플로팅 버튼 탭** → 미니 지도가 왼쪽으로 슬라이드 인 (약 화면 70% 너비)
  - 지도 안: 내 위치(핑크 핀) + 상대방들 위치(파란 핀) + 닉네임 라벨
  - 일러스트 지도 스타일 (SVG, 한강 물줄기 배경)
  - 지도 우측 상단에 **X 버튼** → 지도만 닫기 (오른쪽으로 슬라이드 아웃, 플로팅 버튼 유지)
- **위치 공유 완전 종료**: 지도 하단에 "공유 종료" 버튼 → 플로팅 버튼도 사라짐
- DM에서도 동일 동작 (1:1이므로 상대 핀 1개)
- GPS 좌표: Socket.io로 10초 간격 전송 (카페24 VPS, 추가 비용 없음)
- 지도 표시: 카카오맵 API 무료 또는 SVG 일러스트 지도

**CSS 구현:**
```css
.location-panel {
  position: fixed; top: 0; right: 0; width: 75%; height: 100%;
  background: white; z-index: 180;
  transform: translateX(100%); /* 오른쪽 밖에 숨김 */
  transition: transform 0.3s ease;
  box-shadow: -4px 0 24px rgba(0,0,0,0.15);
}
.location-panel.open {
  transform: translateX(0); /* 왼쪽으로 슬라이드 인 */
}
.location-fab {
  position: fixed; right: 16px; top: 50%;
  width: 48px; height: 48px; border-radius: 50%;
  background: linear-gradient(135deg, #6C3CE1, #D63384);
  color: white; z-index: 170;
  display: none; /* 위치 공유 중일 때만 표시 */
  box-shadow: 0 4px 16px rgba(108,60,225,0.4);
  animation: pulse 2s infinite; /* 공유 중 표시 */
}
```

**JS 흐름:**
```
shareLocation() → locationSharing = true
  → 플로팅 버튼 표시 (display: flex)
  → 채팅에 "📍 위치 공유를 시작했습니다" 시스템 메시지
  → 10초마다 GPS 좌표 전송 (setInterval)

플로팅 버튼 탭 → location-panel.classList.add('open')
X 버튼 탭 → location-panel.classList.remove('open') (패널만 숨김)
"공유 종료" 탭 → locationSharing = false
  → 플로팅 버튼 숨김
  → setInterval 해제
  → 채팅에 "📍 위치 공유를 종료했습니다" 시스템 메시지
```

#### 2. 입장 순서 번호 시스템
- 방 입장 시 자동으로 고유번호 부여 (1번부터 순서대로)
- 채팅 메시지의 닉네임 앞에 `#1`, `#2` 등 번호 표시
- 방장은 항상 #1
- 시스템 메시지: "뚝섬러닝러님이 #3으로 입장했습니다"

#### 3. 랜덤 순서 정하기
- 입력바 `+` 메뉴 → "랜덤 순서"
- 탭하면 현재 방 멤버들을 랜덤 셔플
- 결과를 특별 카드로 채팅에 전송:
  ```
  🎲 랜덤 순서 결과!
  1등: #2 여의도치맥왕
  2등: #1 뚝섬러닝러
  3등: #3 SakuraLover
  ```
- 누구나 다시 뽑기 가능

#### 4. 투표 기능
- 입력바 `+` 메뉴 → "투표 만들기"
- 질문 입력 + 선택지 2~4개 입력 → 생성
- 채팅에 투표 카드로 표시:
  ```
  📊 뭐 먹을까?
  🍗 치킨 ██████ 2표
  🍕 피자 ███ 1표
  ```
- 참여자가 선택지 탭 → 실시간 결과 반영

#### 5. 사다리타기 / 제비뽑기
- 입력바 `+` 메뉴 → "사다리타기" 또는 "제비뽑기"
- **사다리타기**: 참여자 이름 + 결과(벌칙/당첨) 입력 → 애니메이션 → 결과
- **제비뽑기**: 항목 입력 → 랜덤 1개 뽑기 → 결과 카드

#### 6. 더치페이 계산기
- 입력바 `+` 메뉴 → "더치페이"
- 총 금액 입력 → 방 인원수로 자동 나누기
- 결과 카드: "총 45,000원 ÷ 3명 = 1인 15,000원"
- 카카오페이/토스 송금 링크 연결 (mock)

#### 7. 공유 사진 앨범
- 채팅방 헤더의 더보기(⋮) → "사진 앨범"
- 방에서 공유된 사진들 그리드로 모아보기
- 모임 끝난 후에도 열람 가능

### 구현 방식 — 입력바 `+` 버튼 메뉴

현재 `+` 버튼(add_circle)은 onclick이 없음. 여기에 바텀시트 메뉴를 연결:

```
[+] 탭 → 바텀시트 열림:
┌──────────── 도구 ─────────────┐
│ 📍 위치 공유                    │
│ 📊 투표 만들기                  │
│ 💰 더치페이                     │
│ 📷 사진                        │
├──────────── 게임 ─────────────┤
│ 🎲 랜덤 순서                    │
│ ❓ 랜덤 질문 (프리셋+직접등록)   │
│ 🧩 공통점 찾기                  │
│ 😂 밸런스 게임                  │
│ 🎭 역할 배정                    │
│ 💺 자리 정하기                  │
│ 🪜 사다리타기                   │
│ 🎫 제비뽑기                     │
│ 👀 눈치 게임 🔊                │
│ 🔤 초성 게임 🔊                │
│ ⬆️ 업다운 게임 🔊              │
│ 🎭 몸으로 말해요 🔊            │
└────────────────────────────────┘
🔊 = 효과음 포함
```

### 변경 파일

#### HTML (`app/crowny-app-v2.html`)
| 작업 | 내용 |
|------|------|
| CSS | 바텀시트 메뉴, 위치카드, 투표카드, 순서카드, 계산기 스타일 |
| #page-chat-room | `+` 버튼 → 바텀시트 메뉴 연결 |
| #page-dm-room | `+` 버튼 추가 + 위치 공유 메뉴 |
| JS | openPlusMenu(), shareLocation(), randomOrder(), createPoll(), ladderGame(), drawLots(), dutchPay() |
| Mock | 방 멤버 리스트 (번호 포함) 추가 |

#### Flutter
| 파일 | 변경 |
|------|------|
| `models/chat_model.dart` | MessageType에 location, poll, randomOrder, dutchPay 추가 |
| `models/chat_model.dart` | MoimRoomMember (userId, number, nickname) 모델 추가 |
| `mock/mock_data.dart` | 방 멤버 목록 + 번호 데이터 추가 |
| 신규 `widgets/chat_plus_menu.dart` | 바텀시트 메뉴 위젯 |
| 신규 `widgets/poll_card.dart` | 투표 카드 위젯 |
| 신규 `widgets/location_card.dart` | 위치 공유 카드 위젯 |
| 신규 `widgets/random_order_card.dart` | 랜덤 순서 카드 위젯 |

#### Server (Prisma)
| 모델 | 변경 |
|------|------|
| `MoimRoomMember` | `memberNumber Int` 필드 추가 (입장 순서) |
| `ChatMessage.type` | location, poll, random_order, dutch_pay, ladder, draw 추가 |
| 신규 `Poll` 모델 | question, options[], votes[] |

### 입장 번호 표시 위치
- 채팅 메시지 발신자 이름: `#1 뚝섬러닝러`
- 시스템 메시지: `뚝섬러닝러님이 #3으로 입장했습니다`
- 방 헤더 멤버 리스트: `#1 방장 · #2 멤버 · #3 멤버`

#### 8. 랜덤 질문 뽑기
- 입력바 `+` 메뉴 → "랜덤 질문"
- **프리셋 질문**: "요즘 가장 많이 듣는 노래?", "한강 오면 꼭 하는 것?", "인생 맛집은?", "최근 빠진 취미?" (JSON 관리)
- **참여자 질문 등록**: 방에 있는 누구나 "질문 추가" 버튼으로 궁금한 것 직접 입력 → 질문 풀에 추가
- 뽑기 시 프리셋 + 참여자 등록 질문 합쳐서 랜덤 1개 선택
- 질문 카드에 "by #2 여의도치맥왕" 또는 "프리셋" 출처 표시
- 셔플 애니메이션 → 카운트다운 → 질문 카드 등장

#### 9. 공통점 찾기 게임
- 입력바 `+` 메뉴 → "공통점 찾기"
- 랜덤 주제 카드 제시: "좋아하는 음식 장르", "최근 본 영화", "취미" 등
- 참여자들이 답변 입력 → 공통점 자동 매칭 표시
- "🧩 공통점 발견! 3명 모두 한식을 좋아해요!"

#### 10. 밸런스 게임
- 입력바 `+` 메뉴 → "밸런스 게임"
- 랜덤 VS 질문 카드: "치킨 vs 피자", "산 vs 바다", "여름 vs 겨울"
- A/B 버튼 탭 → 실시간 결과 표시 (투표 카드와 유사하되 2개 선택지 고정)
- 프리셋 질문 JSON + 직접 만들기 가능

#### 11. 랜덤 역할 배정
- 입력바 `+` 메뉴 → "역할 배정"
- **자동 모드**: 프리셋 역할 세트 선택 (치맥팟/피크닉팟/러닝팟 등)
  - 치맥팟: 🍗치킨주문 / 🧃음료담당 / 📸사진담당 / 🎮게임진행자
  - 피크닉팟: 🥪음식 / 🎵음악 / 🗑정리 / 📸촬영
- **수동 모드**: 방장이 역할 이름 직접 입력 → 랜덤 배정
- 결과 카드:
  ```
  🎭 역할 배정 결과!
  🍗 치킨 주문: #2 여의도치맥왕
  🧃 음료 담당: #1 뚝섬러닝러
  📸 사진 담당: #3 SakuraLover
  ```

#### 12. 모임 상태 표시
- 방 제목 옆에 상태 아이콘 자동/수동 표시:
  - 🟢 모집중 (기본, 인원 미달)
  - 🟡 곧 시작 (인원 충족 또는 방장이 수동 변경)
  - 🔴 진행중 (방장이 "시작" 누름)
  - ⚫ 종료 (방장이 "종료" 누름 또는 시간 초과)
- 모임방 목록에서도 상태 아이콘 표시
- 상태 변경 시 시스템 메시지: "모임이 시작되었습니다! 🔴"

#### 13. 랜덤 자리 정하기
- 입력바 `+` 메뉴 → "자리 정하기"
- 참여자들을 원형으로 배치한 UI 표시
- "섞기" 탭 → 애니메이션 → 새로운 배치 결과

#### 15. 눈치 게임
- 입력바 `+` 메뉴 → "눈치 게임"
- 1부터 순서대로 숫자를 눌러야 하는데, 순서는 정해져 있지 않음
- 두 명이 동시에 누르면 둘 다 탈락
- **버튼 탭 시 효과음** 재생 (Web Audio API: 짧은 "딩!" 소리)
- 탈락 시 "빵!" 효과음 + 빨간 플래시 애니메이션
- 결과: "🏆 #2 여의도치맥왕 최후의 1인!"

#### 16. 초성 게임
- 입력바 `+` 메뉴 → "초성 게임"
- 랜덤 초성 2~3글자 제시 (예: ㅎㄱ, ㅊㅁ, ㅍㅋㄴ)
- 참여자들이 텍스트 입력 → **제출 버튼 탭 시 효과음** ("톡!" 소리)
- 정답이 여러 개일 수 있으므로 모든 답변을 채팅에 표시
- 제한시간 10초 카운트다운 (카운트다운 효과음: 똑똑똑)

#### 17. 업다운 게임
- 입력바 `+` 메뉴 → "업다운"
- 1~100 사이 랜덤 숫자 선정 (숨김)
- 참여자가 숫자 입력 → ⬆️UP / ⬇️DOWN 표시
- **제출 시 효과음**: UP이면 "띵↑", DOWN이면 "뚱↓"
- 정답 맞추면 🎉 폭죽 애니메이션 + "짠!" 효과음
- 결과: "#3 SakuraLover가 7번 만에 정답! 🎯"

#### 18. 몸으로 말해요
- 입력바 `+` 메뉴 → "몸으로 말해요"
- 카테고리 선택: 동물/음식/유명인/영화/한강관련
- 출제자(방장 또는 랜덤)에게만 제시어 표시
- 나머지 참여자들이 텍스트로 답변 입력
- **제출 시 효과음** ("톡!")
- 정답 시 🎉 + "딩동댕!" 효과음
- 오답 시 "땡!" 효과음

### 효과음 시스템 (Web Audio API)
채팅방 게임들에 사용하는 효과음을 Web Audio API로 구현 (외부 파일 불필요):

```javascript
// 사인파 기반 효과음 생성 (파일 다운로드 없음)
const AudioCtx = window.AudioContext || window.webkitAudioContext;
let audioCtx;

function playSound(type) {
  if (!audioCtx) audioCtx = new AudioCtx();
  const osc = audioCtx.createOscillator();
  const gain = audioCtx.createGain();
  osc.connect(gain);
  gain.connect(audioCtx.destination);

  switch(type) {
    case 'tap':     // 버튼 탭 — 짧은 "톡"
      osc.frequency.value = 800;
      gain.gain.value = 0.3;
      osc.start(); osc.stop(audioCtx.currentTime + 0.08);
      break;
    case 'ding':    // 눈치게임 버튼 — "딩!"
      osc.frequency.value = 1200;
      gain.gain.value = 0.4;
      osc.start(); osc.stop(audioCtx.currentTime + 0.15);
      break;
    case 'buzz':    // 탈락/오답 — "빵!"
      osc.type = 'sawtooth';
      osc.frequency.value = 200;
      gain.gain.value = 0.5;
      osc.start(); osc.stop(audioCtx.currentTime + 0.3);
      break;
    case 'correct': // 정답 — "딩동댕!"
      // 3연속 음: 도-미-솔
      [523, 659, 784].forEach((freq, i) => {
        const o = audioCtx.createOscillator();
        const g = audioCtx.createGain();
        o.connect(g); g.connect(audioCtx.destination);
        o.frequency.value = freq;
        g.gain.value = 0.3;
        o.start(audioCtx.currentTime + i * 0.15);
        o.stop(audioCtx.currentTime + i * 0.15 + 0.15);
      });
      break;
    case 'up':      // 업다운 UP — "띵↑"
      osc.frequency.setValueAtTime(400, audioCtx.currentTime);
      osc.frequency.linearRampToValueAtTime(800, audioCtx.currentTime + 0.15);
      gain.gain.value = 0.3;
      osc.start(); osc.stop(audioCtx.currentTime + 0.15);
      break;
    case 'down':    // 업다운 DOWN — "뚱↓"
      osc.frequency.setValueAtTime(800, audioCtx.currentTime);
      osc.frequency.linearRampToValueAtTime(300, audioCtx.currentTime + 0.2);
      gain.gain.value = 0.3;
      osc.start(); osc.stop(audioCtx.currentTime + 0.2);
      break;
    case 'countdown': // 카운트다운 똑 — 짧은 클릭
      osc.frequency.value = 600;
      gain.gain.value = 0.2;
      osc.start(); osc.stop(audioCtx.currentTime + 0.05);
      break;
    case 'fanfare': // 결과 발표 — 짠!
      [523, 659, 784, 1047].forEach((freq, i) => {
        const o = audioCtx.createOscillator();
        const g = audioCtx.createGain();
        o.connect(g); g.connect(audioCtx.destination);
        o.frequency.value = freq;
        g.gain.value = 0.25;
        o.start(audioCtx.currentTime + i * 0.1);
        o.stop(audioCtx.currentTime + i * 0.1 + 0.2);
      });
      break;
  }
}
```

효과음 종류:
| 효과음 | 용도 | 소리 |
|--------|------|------|
| `tap` | 제출 버튼 탭 | 짧은 "톡" (800Hz, 0.08s) |
| `ding` | 눈치게임 번호 누르기 | 높은 "딩!" (1200Hz, 0.15s) |
| `buzz` | 탈락/오답/동시 누름 | 낮은 "빵!" (톱니파 200Hz, 0.3s) |
| `correct` | 정답 맞춤 | "딩동댕!" (도미솔 3연속) |
| `up` | 업다운 UP | 올라가는 "띵↑" (400→800Hz) |
| `down` | 업다운 DOWN | 내려가는 "뚱↓" (800→300Hz) |
| `countdown` | 카운트다운 5,4,3,2,1 | 짧은 "똑" (600Hz, 0.05s) |
| `fanfare` | 최종 결과 발표 | "짠!" (도미솔도 4연속) |

#### 14. 활동 기록 보기
- 채팅방 헤더의 더보기(⋮) 또는 별도 버튼 → "활동 기록"
- 해당 방에서 진행한 모든 게임/투표/역할배정/랜덤 결과를 시간순으로 모아보기
- 각 기록 항목: 시간 + 종류 아이콘 + 결과 요약
  ```
  19:30  🎲 랜덤 순서 — 1등: #2 여의도치맥왕
  19:35  📊 투표 "뭐 먹을까?" — 치킨 2표로 당선
  19:40  🎭 역할 배정 — 치킨주문:#2, 음료:#1, 사진:#3
  19:45  😂 밸런스 "치킨vs피자" — 치킨 3:1 승리
  20:00  ❓ 랜덤 질문 — "한강 오면 꼭 하는 것?"
  ```
- 기록은 방이 종료(⚫)된 후에도 열람 가능
- 공유 사진 앨범도 이 화면에 탭으로 통합: [기록] [사진]

### 셔플 애니메이션 (공통)
모든 랜덤 기능(순서/역할/자리/질문)에 공통 애니메이션 적용:

1. **셔플 단계**: 번호/카드들이 화투 섞듯이 사방으로 랜덤 이동 (1.5초)
   - CSS: `transform: translate(랜덤X, 랜덤Y) rotate(랜덤deg)`
   - transition: 0.3s ease, 0.15s 간격으로 반복 이동
2. **카운트다운 단계**: 5→4→3→2→1 큰 숫자가 중앙에 나타났다 사라짐
   - 각 숫자: scale(2)→scale(1) + fadeIn→fadeOut (0.8초씩)
   - 보라 그라데이션 텍스트, font-size: 80px, font-weight: 900
3. **결과 단계**: 0일 때 결과 카드가 scale(0)→scale(1) 바운스로 등장
   - CSS: `animation: bounceIn 0.5s cubic-bezier(0.68, -0.55, 0.27, 1.55)`

```css
@keyframes shuffleMove {
  0% { transform: translate(0,0) rotate(0deg); }
  25% { transform: translate(랜덤px, 랜덤px) rotate(랜덤deg); }
  50% { transform: translate(랜덤px, 랜덤px) rotate(랜덤deg); }
  75% { transform: translate(랜덤px, 랜덤px) rotate(랜덤deg); }
  100% { transform: translate(0,0) rotate(0deg); }
}
@keyframes countdownPop {
  0% { transform: scale(2); opacity: 0; }
  30% { transform: scale(1); opacity: 1; }
  70% { transform: scale(1); opacity: 1; }
  100% { transform: scale(0.5); opacity: 0; }
}
@keyframes bounceIn {
  0% { transform: scale(0); }
  50% { transform: scale(1.1); }
  100% { transform: scale(1); }
}
```

### 검증
- `+` 버튼 → 바텀시트 7개 메뉴 표시 확인
- 위치 공유 → 위치 카드 채팅에 표시 확인
- 랜덤 순서 → 셔플 결과 카드 확인
- 투표 만들기 → 투표 카드 + 선택 + 결과 반영 확인
- 사다리타기 → 결과 카드 확인
- 더치페이 → 계산 결과 카드 확인
- 입장 번호 → 닉네임 앞 #N 표시 확인
- DM에서 위치 공유 동작 확인

---

## 화이트라벨 (White-label) 설계

### Context
한강 앱 완성 후 주제(해운대/공원/대학교 등)만 바꿔서 재활용할 수 있도록,
처음부터 **앱 이름/지역/카테고리/색상 등을 설정 파일로 분리**하여 코드에 하드코딩하지 않는다.

### 설정 파일 구조

```
config/
├── app_config.json           ← 현재 활성 설정 (한강)
├── themes/
│   ├── hangang.json          ← 한강 앱
│   ├── haeundae.json         ← 해운대 앱
│   └── campus.json           ← 대학교 앱
└── assets/
    ├── hangang/
    │   ├── home_bg.jpg
    │   ├── map.svg
    │   └── logo.png
    └── haeundae/
        ├── home_bg.jpg
        ├── map.svg
        └── logo.png
```

### 설정 파일 (app_config.json) 스키마

```json
{
  "app": {
    "name": "한강앱",
    "nameEn": "Hangang App",
    "description": "한강에서 새로운 인연을 만나세요",
    "logo": "assets/hangang/logo.png",
    "homeBg": "assets/hangang/home_bg.jpg"
  },
  "theme": {
    "primaryColor": "#6C3CE1",
    "pinkColor": "#D63384",
    "gradientStart": "#5B2FD6",
    "gradientMid": "#7C4DFF",
    "gradientEnd": "#9B72FF"
  },
  "location": {
    "centerLat": 37.5283,
    "centerLng": 126.9346,
    "nearbyRadius": 2000,
    "nearbyBadgeText": "한강근처",
    "mapSvg": "assets/hangang/map.svg"
  },
  "districts": [
    { "id": "yeouido", "name": "여의도", "lat": 37.5247, "lng": 126.9322 },
    { "id": "ttukseom", "name": "뚝섬", "lat": 37.5310, "lng": 127.0660 },
    { "id": "banpo", "name": "반포", "lat": 37.5080, "lng": 126.9950 },
    { "id": "jamsil", "name": "잠실", "lat": 37.5170, "lng": 127.1000 },
    { "id": "mangwon", "name": "망원", "lat": 37.5560, "lng": 126.8950 },
    { "id": "ichon", "name": "이촌", "lat": 37.5220, "lng": 126.9700 }
  ],
  "categories": {
    "hobbies": ["치맥","러닝","산책","피크닉","반려동물","자전거","사진","카페"],
    "interests": ["맛집탐방","야경","음악","언어교환","독서","운동"]
  },
  "games": {
    "balanceQuestions": [
      ["치킨","피자"],["산","바다"],["여름","겨울"],["아침형","저녁형"],
      ["강아지","고양이"],["짜장","짬뽕"],["민트초코 O","민트초코 X"],
      ["소주","맥주"],["카페","편의점"],["드라마","영화"],
      ["한강 낮","한강 밤"],["자전거","러닝"]
    ],
    "presetQuestions": [
      "요즘 가장 많이 듣는 노래?","한강 오면 꼭 하는 것?",
      "인생 맛집은?","최근 빠진 취미?","무인도에 하나만 가져간다면?"
    ],
    "charadesCategories": {
      "동물": ["강아지","고양이","펭귄","코끼리","토끼"],
      "음식": ["치킨","피자","라면","김치찌개","떡볶이"],
      "한강": ["자전거","러닝","치맥","피크닉","야경"]
    },
    "rolePresets": {
      "치맥팟": ["🍗 치킨 주문","🧃 음료 담당","📸 사진 담당","🎮 게임 진행자"],
      "피크닉팟": ["🥪 음식 준비","🎵 음악 담당","🗑 정리 담당","📸 촬영 담당"]
    },
    "choseongList": ["ㅎㄱ","ㅊㅁ","ㅍㅋㄴ","ㅂㅅ","ㄱㅂ","ㅅㅂ","ㅎㄴ"]
  },
  "board": {
    "name": "한강 게시판",
    "categories": ["자유","정보","맛집","사진","질문"]
  },
  "legal": {
    "termsUrl": "/legal/terms.html",
    "privacyUrl": "/legal/privacy.html"
  }
}
```

### 해운대 버전 예시 (haeundae.json)

```json
{
  "app": { "name": "해운대앱", "nameEn": "Haeundae App", "description": "해운대에서 새로운 인연을 만나세요" },
  "location": { "centerLat": 35.1587, "centerLng": 129.1604, "nearbyBadgeText": "해운대근처" },
  "districts": [
    { "id": "haeundae", "name": "해운대해수욕장" },
    { "id": "gwangalli", "name": "광안리" },
    { "id": "songjeong", "name": "송정" }
  ],
  "categories": { "hobbies": ["서핑","횟집","카페","산책","맥주"] },
  "games": { "charadesCategories": { "해운대": ["서핑","횟집","물회","파라솔","모래성"] } },
  "board": { "name": "해운대 게시판" }
}
```

### 코드에서 사용법

**Flutter:**
```dart
// lib/config/app_config.dart
class AppConfig {
  static late Map<String, dynamic> _config;
  static Future<void> load([String theme = 'hangang']) async {
    final json = await rootBundle.loadString('config/themes/$theme.json');
    _config = jsonDecode(json);
  }
  static String get appName => _config['app']['name'];
  static String get nearbyBadge => _config['location']['nearbyBadgeText'];
  static List<String> get districts => (_config['districts'] as List).map((d) => d['name'] as String).toList();
  static Color get primaryColor => Color(int.parse(_config['theme']['primaryColor'].replaceFirst('#','0xFF')));
  // ...
}
```

**HTML:**
```javascript
// config 로드 후 전역에서 사용
let APP = {};
fetch('config/app_config.json').then(r=>r.json()).then(c => {
  APP = c;
  document.title = APP.app.name;
  // 모든 텍스트/색상을 APP에서 참조
});
```

**Server:**
```javascript
// server/src/config/app.js
const config = require('../../../config/app_config.json');
module.exports = config;
// API에서 config.location.nearbyRadius 등 참조
```

### 바꿔야 할 것 vs 공통 코드

| 설정 파일 (주제별 다름) | 공통 코드 (100% 재사용) |
|------------------------|------------------------|
| 앱 이름/설명/로고 | 로그인/회원가입 시스템 |
| 테마 색상 | 채팅/DM 시스템 |
| 지역 목록 + 좌표 | 16개 게임 전체 |
| 일러스트 지도 SVG | 매칭/필터 로직 |
| 카테고리/취미/관심사 | 게시판 CRUD |
| 프리셋 질문/역할/초성 | 프로필/신뢰도 |
| 밸런스 질문/제시어 | 위치공유/검색 |
| 홈 배경이미지 | 글자크기 조절 |
| 배지 텍스트 ("한강근처") | 스와이프 나가기 |
| 법적 문서 URL | 효과음/애니메이션 |

### 새 주제 앱 만드는 과정

```
1. config/themes/새주제.json 작성 (5분)
2. 지도 SVG 제작 (1~2시간)
3. 홈 배경이미지 교체
4. config/app_config.json → 새주제.json 으로 변경
5. 빌드 → 배포
```

**코드 수정 0줄. 설정 파일만 교체.**

### 구현 시 규칙
- 코드에 "한강", "Hangang" 등 주제 관련 문자열을 **절대 하드코딩하지 않음**
- 모든 텍스트는 `AppConfig.xxx`로 참조
- 모든 색상은 `AppConfig.theme.xxx`로 참조
- 모든 지역/카테고리는 `AppConfig.districts` / `AppConfig.categories`로 참조
- 게임 프리셋 데이터도 전부 설정 파일에서 로드

---

## 실제 구현 계획 (HTML 프로토타입 → Flutter 앱)

### Context
HTML 프로토타입(crowny-app-v2.html, 2233줄)이 95% 완성됨.
14개 페이지, 16개 게임, 효과음, 위치공유, 검색, 게시판 등 모든 기능이 Mock으로 동작.
이제 Flutter 앱으로 전환하여 iOS/Android/Web 배포 준비.

### Flutter 현황 (HTML 대비)
- 화면: 12/14 구현됨 (유저프로필상세/채팅방/모집글생성/DM/지도 빠짐)
- 네비: 4탭이나 마지막이 프로필 (→ 게시판으로 변경 필요)
- 게임 시스템: 완전 미구현
- 위치공유/검색/글자조절/스와이프: 미구현

### 구현 순서 (우선순위)

#### Step 0: 화이트라벨 기반 설정
- `config/themes/hangang.json` 생성: 앱이름/색상/지역/카테고리/게임데이터 모든 설정
- `flutter/lib/config/app_config.dart` 신규: JSON 로드 + 전역 접근 싱글톤
- `flutter/lib/app/theme.dart` 수정: 하드코딩 색상 → AppConfig.theme에서 로드
- 모든 "한강" 하드코딩 문자열 제거 → AppConfig.appName 등으로 교체
- HTML도 config fetch 후 동적 텍스트 적용

#### Step 1: Flutter 구조 동기화 (네비 + 라우트)
- `crowny_bottom_nav.dart`: 프로필→게시판 탭 변경
- `main_shell.dart`: IndexedStack에서 Profile→BoardList 교체
- `main.dart`: 빠진 라우트 추가 (/user-profile, /chat-room, /create-room, /dm-room, /map, /search)
- `widgets/app_drawer.dart` 신규: 햄버거 드로어 (프로필/지도/로그인/설정)
- `home_screen.dart`: 햄버거→Drawer 연결, 검색→/search 연결

#### Step 2: 빠진 화면 구현
- `screens/chat/chat_room_screen.dart` 신규: 그룹 채팅방 + 미션 + 입력바
- `screens/chat/create_room_screen.dart` 신규: 모집글 작성 폼
- `screens/chat/dm_room_screen.dart` 신규: 1:1 채팅방
- `screens/profile/user_profile_screen.dart` 신규: 타인 프로필 상세
- `screens/search/search_screen.dart` 신규: 검색 (채팅방/사용자 탭)
- `screens/map/hangang_map_screen.dart` 신규: 한강 일러스트 지도

#### Step 3: 채팅 필터 + DM
- `chat_list_screen.dart` 수정: 상단 3탭 필터 (전체/참여중/1:1)
- `models/chat_model.dart`: DmRoom 모델 추가
- `mock/mock_data.dart`: DM mock 데이터 추가

#### Step 4: 게임 시스템
- `widgets/chat_plus_menu.dart` 신규: 바텀시트 +메뉴 (16개 항목)
- `widgets/game_overlay.dart` 신규: 게임 전체화면 오버레이
- `services/sound_service.dart` 신규: Web Audio → Flutter audioplayers 효과음
- `services/game_service.dart` 신규: 셔플 애니메이션 + 카운트다운
- 개별 게임 위젯: balance, nunchi, choseong, updown, charades, random_order, role_assign, seat_shuffle, draw_lots, poll

#### Step 5: UX 기능
- 글자크기 조절: SharedPreferences + MediaQuery textScaleFactor
- 스와이프 나가기: Dismissible 위젯
- 한강근처 배지: Geolocator 패키지 + 거리 계산
- 위치공유 슬라이드 패널: AnimatedPositioned + Timer

#### Step 6: 서버 API 연결
- Mock 데이터 → HTTP API 호출 교체
- Socket.io 실시간 연결 (채팅, 게임, 위치)
- Firebase Auth 연동 (카카오/구글/Apple)

#### Step 7: 카페24 VPS 배포
- Node.js + PostgreSQL + Redis 서버 세팅
- SSL + PM2 + 자동 백업
- Flutter Web 빌드 → 서버에 배포
- Flutter APK/IPA 빌드

### 핵심 파일 목록

**수정 필요:**
- `flutter/lib/widgets/crowny_bottom_nav.dart` — 프로필→게시판
- `flutter/lib/screens/main_shell.dart` — Profile→BoardList
- `flutter/lib/main.dart` — 라우트 6개 추가
- `flutter/lib/screens/home/home_screen.dart` — 햄버거+검색 연결
- `flutter/lib/screens/chat/chat_list_screen.dart` — 3탭 필터
- `flutter/lib/models/chat_model.dart` — DmRoom 추가
- `flutter/lib/mock/mock_data.dart` — DM + 게시판 mock 추가

**신규 생성:**
- `config/themes/hangang.json` — 한강 앱 설정 (화이트라벨)
- `flutter/lib/config/app_config.dart` — 설정 로더 싱글톤
- `flutter/lib/widgets/app_drawer.dart`
- `flutter/lib/screens/search/search_screen.dart`
- `flutter/lib/screens/chat/chat_room_screen.dart`
- `flutter/lib/screens/chat/create_room_screen.dart`
- `flutter/lib/screens/chat/dm_room_screen.dart`
- `flutter/lib/screens/profile/user_profile_screen.dart`
- `flutter/lib/screens/map/hangang_map_screen.dart`
- `flutter/lib/widgets/chat_plus_menu.dart`
- `flutter/lib/widgets/game_overlay.dart`
- `flutter/lib/services/sound_service.dart`
- `flutter/lib/services/game_service.dart`

### 검증
- Flutter 앱 빌드 성공 (web/android/ios)
- 14개 화면 네비게이션 정상 동작
- 채팅 메시지 전송/수신
- 게임 시작 → 셔플 → 카운트다운 → 결과
- 위치공유 패널 슬라이드
- 검색 결과 표시
- 글자크기 조절 + 저장/복원

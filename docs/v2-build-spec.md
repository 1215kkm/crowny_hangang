# Crowny Hangang v2 — 제작 설계도

## 1. 개요
기존 앱의 대규모 구조 변경:
- 미션 탭 제거 → 채팅방(모임방) 안에서 미션 수행
- 매칭을 필터 기반 사용자 탐색으로 개편
- 채팅을 그룹 모임방 시스템으로 전환
- 프로필 상세보기 + 모집글 작성 추가

---

## 2. 하단 네비게이션 (5탭 → 4탭)

```
Before: 홈 | 매칭 | 미션 | 채팅 | 프로필
After:  홈 | 매칭 | 채팅 | 프로필
```

아이콘: home / waving_hand / forum / person

---

## 3. 페이지 구조 (총 7개)

### 3.1 홈 (#page-home) — 기존 유지
- 히어로 배경이미지 (570px) + 보라 그라데이션 폴백
- 번개 모임 가로 스크롤 카드
- 근처 사용자 리스트
- 게시판/주문 바로가기 배너

### 3.2 매칭 (#page-matching) — 전면 개편

**상단 (보라 배경):**
- 뒤로가기 + "매칭" + 필터 아이콘
- 총 접속자 수: "현재 한강에 127명" (큰 숫자, 글래스 카드)
- 지역 칩 (가로 스크롤): 전체/여의도/뚝섬/반포/잠실/망원/이촌
- 취미 칩 (가로 스크롤): 치맥/러닝/산책/피크닉/반려동물/자전거/사진
- 모드 토글: "같이 놀래요" / "혼자 있을래요"

**하단 (흰색 시트):**
- 사용자 리스트 (필터 적용)
- 각 항목: 그라데이션 아바타(48px) + 닉네임 + Lv배지 + 거리 + 활동
- 최근 참여 모임 표시 (연한 배경, "🍗 치맥 모임 참여 중")
- 사용자 탭 → #page-user-profile 이동

### 3.3 채팅/모임방 (#page-chat) — 전면 개편

**상단 (보라 배경):**
- 뒤로가기 + "모임방" + 모집글작성(+) 버튼

**하단 (흰색 시트):**
모임방 목록, 각 항목 구조:
```
[그라데이션 아이콘] 제목               [자물쇠🔒 or 배지2]
                    방장닉네임 · 지역
                    (3/5명)
```

동작:
- 공개방 (참여중): 배지 있음, 탭 → #page-chat-room
- 공개방 (미참여): 배지 없음, 탭 → 바로 입장 → #page-chat-room
- 비공개방 (미참여): 자물쇠 표시, 탭 → 아코디언 펼침 (상세보기)
  - 펼침 내용: 방장 프로필 카드 + 매너태그 + 한강온도 + 미션정보 + "손흔들기" 버튼
- 미션 있는 방: 미션 아이콘 표시

### 3.4 프로필 (#page-profile) — 기존 유지
- 아바타 + 닉네임 + Lv + 지역
- 통계: 한강온도 / 미션완료 / 매칭성공
- 메뉴: 내 배지, 활동 기록, 관심 목록, 크라우니 상점, 설정

### 3.5 프로필 상세보기 (#page-user-profile) — 신규

**상단 (보라 배경):**
- 뒤로가기 + "프로필"
- 아바타(60px) + 닉네임 + Lv + 거리 + 활동

**하단 (흰색 시트):**
- 한줄 소개 (인용 카드, ::before content '\201C')
- 매너 태그 3개
- 한강 온도 바
- 최근 참여 모임
- 연락처 단계 (Stage 1~4, 잠금된 건 자물쇠)
- "손흔들기" 보라 버튼 + "다음에" 회색 버튼

### 3.6 모집글 작성 (#page-create-room) — 신규

**전체 흰색 배경 (보라 아님):**
- 상단: X닫기 + "모집글 작성" + "등록" 보라 버튼
- 제목 입력 (큰 텍스트필드)
- 내용 입력 (textarea)
- 구분선
- 지역 선택 칩
- 모집 인원 스텝퍼 (- 3 +, 범위 2~10)
- 공개/비공개 토글 (기본: 공개, 보라색)
- 구분선
- 미션 선택 (라디오):
  - 미션 없음 (기본)
  - 가장 웃긴 셀카 📸
  - 주변 특이한 것 찾기 🔍
  - 감동/웃긴 일 공유 💬
  - 오늘 일 공유 📝
  - 본인 소개 (10초 음성) 🎙
  - 직접 정하기 ✏️ → 사진/음성/글 체크박스 + 설명 입력
- 미션 시간 슬라이더 (1~10분, 기본 3분)

### 3.7 그룹 채팅방 (#page-chat-room) — 신규

**상단:**
- 뒤로가기 + 방 제목 + (3/5명) + 더보기(⋮)

**미션 영역 (있을 때만):**
- 미션 카드: 아이콘 + 미션명 + 원형 타이머(SVG) + 남은시간
- "미션 참여" 버튼 → 제출 영역 (사진/음성/텍스트)

**채팅 영역:**
- 상대: 왼쪽 (아바타 + 말풍선)
- 나: 오른쪽 (보라 그라데이션 말풍선)
- 미션 결과: 특별 카드 형태
- 시스템: 중앙 ("OO님이 입장했습니다")

**하단 입력바:**
- 텍스트 + 전송 + 사진 + 미션추가(+)

---

## 4. Mock 데이터

```javascript
const MOCK = {
  totalOnline: 127,
  rooms: [
    { id:'r1', title:'여의도 치맥 모임', creator:'여의도치맥왕', district:'여의도',
      icon:'sports_bar', gradient:'blue', current:3, max:5, isJoined:true,
      unread:2, isPrivate:false, mission:null, creatorLv:5, temp:42.1,
      tags:['맛집 마스터','유머 만렙','분위기 메이커'] },
    { id:'r2', title:'한강 러닝 크루', creator:'뚝섬러닝러', district:'뚝섬',
      icon:'directions_run', gradient:'pink', current:2, max:4, isJoined:false,
      unread:0, isPrivate:true,
      mission:{type:'selfie',name:'가장 웃긴 셀카',time:180},
      creatorLv:3, temp:38.5, tags:['시간 잘 지켜요','대화 재밌어요','분위기 메이커'] },
    { id:'r3', title:'야경 사진 찍을 사람', creator:'SakuraLover', district:'반포',
      icon:'photo_camera', gradient:'orange', current:1, max:3, isJoined:false,
      isPrivate:false, unread:0,
      mission:{type:'find_unusual',name:'주변 특이한 것 찾기',time:300},
      creatorLv:1, temp:36.8, tags:['사진 잘 찍어줘요'] },
    { id:'r4', title:'편의점 라면 파티', creator:'한강멍멍이', district:'잠실',
      icon:'ramen_dining', gradient:'purple', current:4, max:6, isJoined:true,
      isPrivate:false, unread:0, mission:null, creatorLv:2, temp:37.2,
      tags:['배려심 넘쳐요','시간 잘 지켜요'] },
    { id:'r5', title:'자전거 한강 종주', creator:'망원자전거', district:'망원',
      icon:'pedal_bike', gradient:'blue', current:2, max:3, isJoined:false,
      isPrivate:true, unread:0,
      mission:{type:'voice_intro',name:'본인 소개 (10초 음성)',time:60},
      creatorLv:4, temp:39.5, tags:['시간 잘 지켜요','대화 재밌어요'] },
  ],
  users: [
    { id:'u1', nickname:'뚝섬러닝러', icon:'directions_run', gradient:'pink',
      lv:3, dist:120, activity:'러닝 중', mood:'play',
      hobbies:['러닝','산책'], recentMoim:'한강 러닝 크루' },
    { id:'u2', nickname:'여의도치맥왕', icon:'sports_bar', gradient:'blue',
      lv:5, dist:200, activity:'치맥 중', mood:'play',
      hobbies:['치맥','맛집'], recentMoim:'여의도 치맥 모임' },
    { id:'u3', nickname:'SakuraLover', icon:'photo_camera', gradient:'orange',
      lv:1, dist:350, activity:'사진 촬영', mood:'play',
      hobbies:['사진','산책'], recentMoim:'야경 사진 찍을 사람' },
    { id:'u4', nickname:'한강멍멍이', icon:'pets', gradient:'purple',
      lv:2, dist:450, activity:'산책 중', mood:'alone',
      hobbies:['반려동물','산책'], recentMoim:'편의점 라면 파티' },
    { id:'u5', nickname:'망원카페러', icon:'local_cafe', gradient:'blue',
      lv:3, dist:500, activity:'카페', mood:'alone',
      hobbies:['카페','독서'], recentMoim:null },
  ],
  chatMessages: [
    { sender:'여의도치맥왕', isMe:false, text:'치킨 주문했어요! 빨리 오세요~ 🍗', time:'19:30' },
    { sender:'나', isMe:true, text:'오 좋아요! 어디서 만날까요?', time:'19:31' },
    { sender:'여의도치맥왕', isMe:false, text:'여의도 2지구 편의점 앞이요!', time:'19:32' },
    { sender:'system', isMe:false, text:'뚝섬러닝러님이 입장했습니다', time:'19:33', isSystem:true },
    { sender:'뚝섬러닝러', isMe:false, text:'안녕하세요! 저도 합류합니다 🏃', time:'19:33' },
  ]
};
```

---

## 5. CSS 디자인 토큰

```css
:root {
  --purple: #6C3CE1;
  --pink: #D63384;
  --orange: #E8590C;
  --cyan: #0EA5E9;
  --green: #059669;
  --font: 'Noto Sans KR', -apple-system, sans-serif;
}

/* 배경 그라데이션 */
background: linear-gradient(165deg, #5B2FD6 0%, #7C4DFF 35%, #9B72FF 100%);

/* 흰색 시트 */
.sheet { background: white; border-radius: 32px 32px 0 0; padding: 28px 24px 100px; }

/* 그라데이션 아이콘 박스 */
.g-pink { background: linear-gradient(135deg, #F43F5E, #E8590C); }
.g-blue { background: linear-gradient(135deg, #0EA5E9, #2563EB); }
.g-orange { background: linear-gradient(135deg, #F59E0B, #E8590C); }
.g-purple { background: linear-gradient(135deg, #7C4DFF, #5B2FD6); }

/* 글래스 카드 */
background: rgba(255,255,255,0.18); backdrop-filter: blur(10px); border-radius: 16px;

/* 그라데이션 버튼 */
background: linear-gradient(135deg, #6C3CE1, #D63384);
box-shadow: 0 4px 16px rgba(108,60,225,0.4);

/* max-width */
body { max-width: 390px; margin: 0 auto; }
```

---

## 6. JavaScript 함수 목록

| 함수 | 설명 |
|------|------|
| `switchPage(name)` | 페이지 전환 + 네비 업데이트 + 스크롤 맨위. name: home/matching/chat/profile/user-profile/create-room/chat-room |
| `toggleMoimDetail(id)` | 모임방 아코디언 토글 (비공개방 상세보기) |
| `applyFilter()` | 매칭 필터 적용 (지역/취미/모드 기반 사용자 필터링) |
| `startRoomTimer()` | 채팅방 미션 타이머 (SVG 원형 진행바 + 카운트다운) |
| `showMissionSubmit(type)` | 미션 제출 영역 표시 (photo/voice/text) |
| `sendMessage()` | 채팅 메시지 전송 (내 말풍선으로 추가) |
| `addPeople(delta)` | 모집인원 스텝퍼 (+/-) |
| `selectMission(type)` | 미션 선택 라디오 토글 |
| `togglePrivacy()` | 공개/비공개 토글 |

---

## 7. 아코디언 (모임방 상세보기) 구현

```css
.moim-detail {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.3s ease, padding 0.3s ease;
}
.moim-detail.open {
  max-height: 500px;
  padding: 16px;
}
```

```javascript
function toggleMoimDetail(id) {
  const detail = document.getElementById('moim-detail-' + id);
  detail.classList.toggle('open');
}
```

---

## 8. 원형 타이머 SVG

```html
<svg viewBox="0 0 120 120" width="80" height="80" style="transform:rotate(-90deg)">
  <defs>
    <linearGradient id="tg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#7B61FF"/>
      <stop offset="100%" stop-color="#E845A0"/>
    </linearGradient>
  </defs>
  <circle cx="60" cy="60" r="52" fill="none" stroke="#EDE9FE" stroke-width="6"/>
  <circle cx="60" cy="60" r="52" fill="none" stroke="url(#tg)" stroke-width="6"
    stroke-linecap="round" stroke-dasharray="326" stroke-dashoffset="95" id="roomTimerCircle"/>
</svg>
```

---

## 9. 모임방 입장 방식

- **기본: 공개방** — 누구나 바로 입장
- **방장이 비공개 선택 시**:
  1. 목록에 자물쇠(🔒) 표시
  2. 탭하면 아코디언 상세보기 펼침
  3. "손흔들기" 버튼 → 방장에게 알림
  4. 방장 수락 → 입장

---

## 10. 채팅 말풍선 CSS

```css
/* 상대 메시지 */
.msg-other {
  display: flex; gap: 8px; margin-bottom: 12px;
}
.msg-bubble {
  background: #F3F4F6; border-radius: 18px 18px 18px 4px;
  padding: 10px 14px; font-size: 14px; color: #1E1B4B;
  max-width: 70%;
}
.msg-sender { font-size: 11px; font-weight: 700; color: #6B7280; margin-bottom: 2px; }
.msg-time { font-size: 10px; color: #D1D5DB; margin-top: 2px; }

/* 내 메시지 */
.msg-me {
  display: flex; justify-content: flex-end; margin-bottom: 12px;
}
.msg-me .msg-bubble {
  background: linear-gradient(135deg, #6C3CE1, #D63384);
  color: white; border-radius: 18px 18px 4px 18px;
}

/* 시스템 메시지 */
.msg-system {
  text-align: center; font-size: 11px; color: #9CA3AF;
  margin: 16px 0; padding: 6px 16px;
  background: #F9FAFB; border-radius: 20px; display: inline-block;
}

/* 미션 결과 카드 */
.msg-mission-card {
  background: #F9F7FF; border: 1px solid #EDE9FE; border-radius: 16px;
  padding: 12px; max-width: 70%;
}
```

---

## 11. 입력바

```css
.input-bar {
  position: fixed; bottom: 0; left: 50%; transform: translateX(-50%);
  width: 100%; max-width: 390px;
  background: white; border-top: 1px solid #F3F4F6;
  padding: 8px 16px max(8px, env(safe-area-inset-bottom));
  display: flex; align-items: center; gap: 8px;
}
.input-field {
  flex: 1; border: 1px solid #E5E7EB; border-radius: 20px;
  padding: 10px 16px; font-size: 14px; outline: none;
  font-family: var(--font);
}
.input-field:focus { border-color: var(--purple); }
.send-btn {
  width: 36px; height: 36px; border-radius: 50%;
  background: linear-gradient(135deg, #6C3CE1, #D63384);
  color: white; border: none; display: flex;
  align-items: center; justify-content: center; cursor: pointer;
}
```

---

## 12. 필터 칩 CSS

```css
.chip-scroll {
  display: flex; gap: 8px; overflow-x: auto; padding: 0 24px 12px;
  scrollbar-width: none;
}
.chip-scroll::-webkit-scrollbar { display: none; }
.chip {
  padding: 8px 16px; border-radius: 20px; font-size: 12px; font-weight: 600;
  white-space: nowrap; cursor: pointer; transition: all 0.2s;
  border: 1px solid rgba(255,255,255,0.3); color: rgba(255,255,255,0.8);
  background: rgba(255,255,255,0.1); flex-shrink: 0;
}
.chip.active {
  background: white; color: var(--purple); border-color: white;
}
```

---

## 13. 모드 토글

```css
.mode-toggle {
  display: flex; margin: 0 24px 20px;
  background: rgba(255,255,255,0.15); border-radius: 14px; padding: 3px;
}
.mode-btn {
  flex: 1; padding: 10px; text-align: center; border-radius: 12px;
  font-size: 13px; font-weight: 700; cursor: pointer; transition: all 0.25s;
  color: rgba(255,255,255,0.7); border: none; background: none;
  font-family: var(--font);
}
.mode-btn.active {
  background: white; color: var(--purple);
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
```

---

## 14. 연락처 단계 (프로필 상세)

```html
<div class="contact-stages">
  <div class="stage unlocked">
    <span class="mi">badge</span>
    <div>Stage 1: 닉네임</div>
    <span class="stage-val">뚝섬러닝러</span>
  </div>
  <div class="stage unlocked">
    <span class="mi">chat</span>
    <div>Stage 2: 앱 내 채팅</div>
    <span class="mi stage-lock">check_circle</span>
  </div>
  <div class="stage locked">
    <span class="mi">share</span>
    <div>Stage 3: SNS 교환</div>
    <span class="mi stage-lock">lock</span>
  </div>
  <div class="stage locked">
    <span class="mi">person</span>
    <div>Stage 4: 상세 프로필</div>
    <span class="mi stage-lock">lock</span>
  </div>
</div>
```

```css
.contact-stages { display: flex; flex-direction: column; gap: 8px; margin: 20px 0; }
.stage {
  display: flex; align-items: center; gap: 12px; padding: 12px 16px;
  border-radius: 14px; font-size: 13px; font-weight: 600;
}
.stage.unlocked { background: #F0FDF4; color: #059669; }
.stage.locked { background: #F9FAFB; color: #D1D5DB; }
.stage-val { margin-left: auto; font-weight: 700; }
.stage-lock { margin-left: auto; font-size: 18px; }
```

---

## 15. 폰트/CDN

```html
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
```

Material Icons 사용법: `<span class="mi">icon_name</span>`
(`.mi` 클래스 = font-family: Material Icons Round)

---

## 16. 모집글 작성 폼 구조

```
┌──────────────────────────────┐
│  ✕ 닫기    모집글 작성    [등록]  │
├──────────────────────────────┤
│  제목 입력                       │
│  ──────────────────────────   │
│  내용 입력 (textarea)            │
│  ──────────────────────────   │
│  지역: [여의도] [뚝섬] [반포]...  │
│  ──────────────────────────   │
│  모집 인원:  [−]  3명  [+]       │
│  ──────────────────────────   │
│  공개방 ●───────○ 비공개방       │
│  ──────────────────────────   │
│  미션 선택:                      │
│  ○ 미션 없음                     │
│  ○ 가장 웃긴 셀카 📸             │
│  ○ 주변 특이한 것 찾기 🔍        │
│  ○ 감동/웃긴 일 공유 💬          │
│  ○ 오늘 일 공유 📝               │
│  ○ 본인 소개 (10초 음성) 🎙      │
│  ○ 직접 정하기 ✏️                │
│    → [✓사진] [✓음성] [✓글]      │
│    → 설명 입력                   │
│  ──────────────────────────   │
│  미션 시간: ────●──── 3분        │
└──────────────────────────────┘
```

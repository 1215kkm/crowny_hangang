/* ============================================
   Crowny Admin - 메인 앱 JS
   사이드바 네비게이션 + 디자인/미션/언어 관리
   ============================================ */

// ── 사이드바 네비게이션 ──
document.querySelectorAll('.menu-item[data-page]').forEach(item => {
  item.addEventListener('click', () => {
    document.querySelectorAll('.menu-item').forEach(m => m.classList.remove('active'));
    item.classList.add('active');

    const pageId = item.dataset.page;
    document.querySelectorAll('.page-section').forEach(s => s.classList.remove('active'));
    const target = document.getElementById('page-' + pageId);
    if (target) target.classList.add('active');
  });
});

// ── 언어 탭 ──
document.querySelectorAll('.tabs .tab[data-lang]').forEach(tab => {
  tab.addEventListener('click', () => {
    document.querySelectorAll('.tabs .tab').forEach(t => t.classList.remove('active'));
    tab.classList.add('active');
    loadLanguageEditor(tab.dataset.lang);
  });
});

// ── 색상 입력 동기화 ──
document.querySelectorAll('.color-preview').forEach(picker => {
  picker.addEventListener('input', (e) => {
    const token = e.target.dataset.token;
    const textInput = document.querySelector(`.color-input[data-token="${token}"]`);
    if (textInput) textInput.value = e.target.value;
  });
});

document.querySelectorAll('.color-input').forEach(input => {
  input.addEventListener('input', (e) => {
    const token = e.target.dataset.token;
    const picker = document.querySelector(`.color-preview[data-token="${token}"]`);
    if (picker && /^#[0-9A-Fa-f]{6}$/.test(e.target.value)) {
      picker.value = e.target.value;
    }
  });
});

// ── 디자인 관리 ──
function resetDesign() {
  if (confirm('모든 디자인 변수를 기본값으로 복원하시겠습니까?')) {
    const defaults = {
      primary: '#6C3CE1',
      secondary: '#D63384',
      accent: '#E8590C',
      bgPurple: '#5B2FD6',
      bgCard: '#F9F7FF',
    };
    Object.entries(defaults).forEach(([token, value]) => {
      const picker = document.querySelector(`.color-preview[data-token="${token}"]`);
      const input = document.querySelector(`.color-input[data-token="${token}"]`);
      if (picker) picker.value = value;
      if (input) input.value = value;
    });
    alert('기본값으로 복원되었습니다.');
  }
}

function applyDesign() {
  const tokens = {};
  document.querySelectorAll('.color-input').forEach(input => {
    tokens[input.dataset.token] = input.value;
  });
  console.log('Design tokens applied:', tokens);
  alert('디자인이 전체 적용되었습니다.\n(실제 서버 연동 후 Flutter 앱에 반영됩니다)');
}

// ── 미션 관리 ──
function addMission() {
  alert('미션 추가 모달 (구현 예정)\n\n필드: 텍스트, 설명, 아이콘, 타이머(초), 타입, 난이도, 태그, 시즌, 지역');
}

// ── 언어 관리 ──
const langData = {
  ko: null,
  en: null,
};

async function loadLanguageData() {
  try {
    const koRes = await fetch('lang/ko.json');
    langData.ko = await koRes.json();
    const enRes = await fetch('lang/en.json');
    langData.en = await enRes.json();
  } catch (e) {
    console.warn('Language files not loaded:', e);
    // 폴백 데이터
    langData.ko = {
      common: { app_name: '크라우니 한강', confirm: '확인', cancel: '취소' },
      home: { title: '한강', nearby: '근처 사용자', wave: '손 흔들기' },
      matching: { title: '매칭', lets_play: '같이 놀자!' },
      mission: { title: '미션 타이머', start: '미션 시작!' },
    };
    langData.en = {
      common: { app_name: 'Crowny Hangang', confirm: 'Confirm', cancel: 'Cancel' },
      home: { title: 'Hangang', nearby: 'Nearby', wave: 'Wave' },
      matching: { title: 'Matching', lets_play: "Let's hang out!" },
      mission: { title: 'Mission Timer', start: 'Start Mission!' },
    };
  }
  loadLanguageEditor('ko');
}

function loadLanguageEditor(lang) {
  const data = langData[lang];
  if (!data) return;

  const container = document.getElementById('lang-editor');
  container.innerHTML = '';

  Object.entries(data).forEach(([section, values]) => {
    if (section === '_meta') return;
    if (typeof values !== 'object') return;

    const card = document.createElement('div');
    card.className = 'lang-card';

    const keys = Object.entries(values);
    card.innerHTML = `
      <div class="lang-header">
        <div class="lang-title">${section}</div>
        <div class="lang-count">${keys.length}개 항목</div>
      </div>
      ${keys.map(([key, value]) => `
        <div class="lang-item">
          <div class="lang-key">${key}</div>
          <input type="text" class="lang-value" value="${value}" data-section="${section}" data-key="${key}">
        </div>
      `).join('')}
    `;
    container.appendChild(card);
  });
}

// 초기화
loadLanguageData();

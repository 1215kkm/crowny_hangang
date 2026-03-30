import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../widgets/gradient_icon_box.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _locationSharing = true;
  bool _pushNotification = true;
  bool _matchNotification = true;
  bool _chatTranslation = false;
  String _language = 'ko';
  String _district = 'yeouido';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CrownyTheme.bgPage,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: CrownyTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('설정', style: TextStyle(fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary, fontSize: 18)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(CrownyTheme.pagePadding),
        children: [
          // ── 계정 ──
          _SectionTitle(title: '계정'),
          _SettingsCard(children: [
            _ProfileRow(),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsItem(
              icon: Icons.verified_rounded,
              iconGradient: 'purple',
              title: '본인 인증',
              subtitle: '신뢰 레벨을 올려보세요',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: CrownyTheme.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Lv.2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CrownyTheme.accent)),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsItem(
              icon: Icons.edit_rounded,
              iconGradient: 'blue',
              title: '별명 변경',
              subtitle: '주 1회 변경 가능 · 남은 횟수: 1회',
              trailing: const Icon(Icons.chevron_right_rounded, color: CrownyTheme.textMuted, size: 20),
            ),
          ]),
          const SizedBox(height: 20),

          // ── 위치 ──
          _SectionTitle(title: '위치'),
          _SettingsCard(children: [
            _SettingsToggle(
              icon: Icons.location_on_rounded,
              iconGradient: 'pink',
              title: '위치 공유',
              subtitle: '앱 사용 중 위치를 다른 사용자에게 표시',
              value: _locationSharing,
              onChanged: (v) => setState(() => _locationSharing = v),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsItem(
              icon: Icons.map_rounded,
              iconGradient: 'blue',
              title: '기본 한강 지구',
              subtitle: _districtName(_district),
              trailing: DropdownButton<String>(
                value: _district,
                underline: const SizedBox(),
                icon: const Icon(Icons.expand_more_rounded, size: 18, color: CrownyTheme.textMuted),
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.primary),
                items: const [
                  DropdownMenuItem(value: 'yeouido', child: Text('여의도')),
                  DropdownMenuItem(value: 'ttukseom', child: Text('뚝섬')),
                  DropdownMenuItem(value: 'banpo', child: Text('반포')),
                  DropdownMenuItem(value: 'jamsil', child: Text('잠실')),
                  DropdownMenuItem(value: 'mangwon', child: Text('망원')),
                  DropdownMenuItem(value: 'ichon', child: Text('이촌')),
                ],
                onChanged: (v) => setState(() => _district = v ?? 'yeouido'),
              ),
            ),
          ]),
          const SizedBox(height: 20),

          // ── 알림 ──
          _SectionTitle(title: '알림'),
          _SettingsCard(children: [
            _SettingsToggle(
              icon: Icons.notifications_rounded,
              iconGradient: 'orange',
              title: '푸시 알림',
              subtitle: '매칭, 채팅, 이벤트 알림',
              value: _pushNotification,
              onChanged: (v) => setState(() => _pushNotification = v),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsToggle(
              icon: Icons.waving_hand_rounded,
              iconGradient: 'purple',
              title: '매칭 알림',
              subtitle: '손흔들기 수신 시 알림',
              value: _matchNotification,
              onChanged: (v) => setState(() => _matchNotification = v),
            ),
          ]),
          const SizedBox(height: 20),

          // ── 언어 ──
          _SectionTitle(title: '언어'),
          _SettingsCard(children: [
            _SettingsItem(
              icon: Icons.language_rounded,
              iconGradient: 'blue',
              title: '앱 언어',
              subtitle: _languageName(_language),
              trailing: DropdownButton<String>(
                value: _language,
                underline: const SizedBox(),
                icon: const Icon(Icons.expand_more_rounded, size: 18, color: CrownyTheme.textMuted),
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.primary),
                items: const [
                  DropdownMenuItem(value: 'ko', child: Text('한국어')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ja', child: Text('日本語')),
                ],
                onChanged: (v) => setState(() => _language = v ?? 'ko'),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsToggle(
              icon: Icons.translate_rounded,
              iconGradient: 'pink',
              title: '자동 번역',
              subtitle: '채팅 메시지 자동 번역',
              value: _chatTranslation,
              onChanged: (v) => setState(() => _chatTranslation = v),
            ),
          ]),
          const SizedBox(height: 20),

          // ── 안전 ──
          _SectionTitle(title: '안전'),
          _SettingsCard(children: [
            _SettingsItem(
              icon: Icons.shield_rounded,
              iconGradient: 'purple',
              title: '차단 사용자 관리',
              subtitle: '차단한 사용자 목록',
              trailing: const Icon(Icons.chevron_right_rounded, color: CrownyTheme.textMuted, size: 20),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsItem(
              icon: Icons.emergency_rounded,
              iconGradient: 'pink',
              title: '비상 연락처 설정',
              subtitle: '타임아웃 체크인 시 알림 받을 연락처',
              trailing: const Icon(Icons.chevron_right_rounded, color: CrownyTheme.textMuted, size: 20),
            ),
          ]),
          const SizedBox(height: 20),

          // ── 정보 ──
          _SectionTitle(title: '정보'),
          _SettingsCard(children: [
            _SettingsItem(
              icon: Icons.description_rounded,
              iconGradient: 'blue',
              title: '이용약관',
              trailing: const Icon(Icons.chevron_right_rounded, color: CrownyTheme.textMuted, size: 20),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsItem(
              icon: Icons.privacy_tip_rounded,
              iconGradient: 'orange',
              title: '개인정보처리방침',
              trailing: const Icon(Icons.chevron_right_rounded, color: CrownyTheme.textMuted, size: 20),
            ),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            _SettingsItem(
              icon: Icons.info_rounded,
              iconGradient: 'purple',
              title: '앱 버전',
              trailing: const Text('1.0.0', style: TextStyle(fontSize: 13, color: CrownyTheme.textMuted)),
            ),
          ]),
          const SizedBox(height: 20),

          // 로그아웃
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
                border: Border.all(color: CrownyTheme.error.withValues(alpha: 0.2)),
              ),
              child: const Center(
                child: Text('로그아웃', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.error)),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 회원 탈퇴
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('회원 탈퇴', style: TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  String _districtName(String id) {
    const map = {'yeouido': '여의도', 'ttukseom': '뚝섬', 'banpo': '반포', 'jamsil': '잠실', 'mangwon': '망원', 'ichon': '이촌'};
    return map[id] ?? id;
  }

  String _languageName(String code) {
    const map = {'ko': '한국어', 'en': 'English', 'ja': '日本語'};
    return map[code] ?? code;
  }
}

// ── 위젯 ──

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textSecondary)),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
        boxShadow: CrownyTheme.shadowSm,
      ),
      child: Column(children: children),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const GradientIconBox(icon: Icons.person_rounded, gradientType: 'purple', size: 50, iconSize: 26, borderRadius: 16),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('한강탐험가', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
                SizedBox(height: 2),
                Text('카카오 로그인 · 여의도', style: TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: CrownyTheme.textMuted, size: 20),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String iconGradient;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _SettingsItem({required this.icon, required this.iconGradient, required this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GradientIconBox(icon: icon, gradientType: iconGradient, size: 36, iconSize: 18, borderRadius: 10),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                if (subtitle != null) ...[
                  const SizedBox(height: 1),
                  Text(subtitle!, style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  final IconData icon;
  final String iconGradient;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggle({
    required this.icon,
    required this.iconGradient,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GradientIconBox(icon: icon, gradientType: iconGradient, size: 36, iconSize: 18, borderRadius: 10),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                const SizedBox(height: 1),
                Text(subtitle, style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: CrownyTheme.primary,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';

class ProfileScreen extends StatelessWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const ProfileScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return PurpleScaffold(
      title: '프로필',
      leading: const SizedBox(width: 40),
      trailing: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.settings_rounded, color: Colors.white, size: 22),
      ),
      topContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CrownyTheme.pagePadding),
        child: Column(
          children: [
            // 아바타
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.person_rounded, size: 44, color: Colors.white),
            ),
            const SizedBox(height: 14),
            const Text('한강탐험가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
            const SizedBox(height: 4),
            Text('📍 여의도 한강공원', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8))),
            const SizedBox(height: 8),
            // 별명 변경
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(CrownyTheme.radiusFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_rounded, size: 14, color: Colors.white.withValues(alpha: 0.8)),
                  const SizedBox(width: 4),
                  Text('별명 변경 (주 1회)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.8))),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      sheetContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // 한강 온도
          _StatCard(
            icon: Icons.thermostat_rounded,
            title: '한강 온도',
            value: '37.2°',
            progress: 0.24,
            gradientType: 'purple',
          ),
          const SizedBox(height: 12),

          // 만남 횟수
          _StatCard(
            icon: Icons.group_rounded,
            title: '만남 횟수',
            value: '5회',
            progress: 0.1,
            gradientType: 'blue',
          ),
          const SizedBox(height: 12),

          // 신뢰 레벨
          _StatCard(
            icon: Icons.verified_rounded,
            title: '신뢰 레벨',
            value: 'Lv.2',
            progress: 0.4,
            gradientType: 'pink',
          ),
          const SizedBox(height: 24),

          // 연락처 단계
          const Text('연락처 단계', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          const SizedBox(height: 12),
          _ContactStageItem(stage: 1, title: '한강 닉네임', sub: '모든 사용자에게 표시', isActive: true),
          _ContactStageItem(stage: 2, title: '앱 내 채팅', sub: '매칭 후 사용 가능', isActive: true),
          _ContactStageItem(stage: 3, title: '카카오/인스타/전화번호', sub: '상호 동의 시 공개', isActive: false),
          _ContactStageItem(stage: 4, title: '상세 프로필', sub: '직업, 관심사, 실명', isActive: false),
          const SizedBox(height: 24),

          // 매너 태그
          const Text('받은 매너 태그', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagChip(text: '시간 잘 지켜요', count: 3),
              _TagChip(text: '배려심 넘쳐요', count: 2),
              _TagChip(text: '대화 재밌어요', count: 2),
            ],
          ),
          const SizedBox(height: 24),

          // 배지
          const Text('배지', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          const SizedBox(height: 12),
          Row(
            children: [
              _BadgeItem(icon: Icons.water_drop_rounded, title: '한강 입문', gradientType: 'blue'),
              const SizedBox(width: 12),
              _BadgeItem(icon: Icons.nightlight_rounded, title: '야행성', gradientType: 'purple'),
              const SizedBox(width: 12),
              _BadgeItem(icon: Icons.lock_rounded, title: '???', gradientType: 'orange', isLocked: true),
            ],
          ),
        ],
      ),
      bottomNav: CrownyBottomNav(currentIndex: navIndex, onTap: onNavTap),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final double progress;
  final String gradientType;

  const _StatCard({required this.icon, required this.title, required this.value, required this.progress, required this.gradientType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CrownyTheme.bgCard,
        borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
      ),
      child: Row(
        children: [
          GradientIconBox(icon: icon, gradientType: gradientType, size: 42, iconSize: 22, borderRadius: 14),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFEDE9FE),
                    valueColor: AlwaysStoppedAnimation(CrownyTheme.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: CrownyTheme.accent)),
        ],
      ),
    );
  }
}

class _ContactStageItem extends StatelessWidget {
  final int stage;
  final String title;
  final String sub;
  final bool isActive;

  const _ContactStageItem({required this.stage, required this.title, required this.sub, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: CrownyTheme.bgCard,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: isActive ? CrownyTheme.primary : CrownyTheme.textMuted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text('$stage', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                    Text(sub, style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                  ],
                ),
              ),
              Icon(isActive ? Icons.check_circle_rounded : Icons.lock_rounded, size: 18, color: isActive ? CrownyTheme.green : CrownyTheme.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;
  final int count;
  const _TagChip({required this.text, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: CrownyTheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text('$text ($count)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CrownyTheme.primary)),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String gradientType;
  final bool isLocked;

  const _BadgeItem({required this.icon, required this.title, required this.gradientType, this.isLocked = false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLocked ? 0.35 : 1.0,
      child: Column(
        children: [
          GradientIconBox(icon: icon, gradientType: gradientType, size: 50, iconSize: 26, borderRadius: 16),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: CrownyTheme.textSecondary)),
        ],
      ),
    );
  }
}

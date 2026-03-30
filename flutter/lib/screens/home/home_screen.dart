import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const HomeScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return PurpleScaffold(
      leading: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
      ),
      trailing: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.search_rounded, color: Colors.white, size: 22),
      ),
      topContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CrownyTheme.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('안녕하세요 👋', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.9))),
            const SizedBox(height: 6),
            const Text(
              '한강에서\n새로운 인연을 만나세요',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, height: 1.35),
            ),
            const SizedBox(height: 20),

            // 접속자 카드
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.group_rounded, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('12명', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                        Text('여의도 한강공원 접속 중', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.75))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: CrownyTheme.accent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: CrownyTheme.accent.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: const Text('둘러보기', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 활동 아이콘 그리드
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: MockData.activities.map((a) {
                return Column(
                  children: [
                    GradientIconBox(
                      icon: _getActivityIcon(a['icon'] as String),
                      gradientType: a['gradient'] as String,
                      size: 54,
                      iconSize: 26,
                    ),
                    const SizedBox(height: 8),
                    Text(a['name'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.9))),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      sheetContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 번개 모임
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('번개 모임', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
              Row(
                children: [
                  Text('View all', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.primary)),
                  Icon(Icons.chevron_right_rounded, size: 16, color: CrownyTheme.primary),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MockData.flashEvents.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final e = MockData.flashEvents[i];
                return Container(
                  width: 170,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CrownyTheme.bgCard,
                    borderRadius: BorderRadius.circular(CrownyTheme.radiusLg),
                    border: Border.all(color: const Color(0xFFEDE9FE)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientIconBox(icon: _getActivityIcon(e.icon), gradientType: e.gradientType, size: 42, iconSize: 22, borderRadius: 14),
                      const SizedBox(height: 10),
                      Text(e.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                      const SizedBox(height: 3),
                      Text('${e.location} · ${e.currentPeople}/${e.maxPeople}명', style: const TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 28),

          // 근처 사용자
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('근처 사용자', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
              Row(
                children: [
                  Text('View all', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.primary)),
                  Icon(Icons.chevron_right_rounded, size: 16, color: CrownyTheme.primary),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...MockData.nearbyUsers.map((u) => _UserTile(user: u)),
        ],
      ),
      bottomNav: CrownyBottomNav(currentIndex: navIndex, onTap: onNavTap),
    );
  }

  static IconData _getActivityIcon(String name) {
    const map = {
      'sports_bar': Icons.sports_bar_rounded,
      'directions_run': Icons.directions_run_rounded,
      'hiking': Icons.hiking_rounded,
      'deck': Icons.deck_rounded,
      'restaurant': Icons.restaurant_rounded,
      'nightlight': Icons.nightlight_rounded,
      'photo_camera': Icons.photo_camera_rounded,
      'pets': Icons.pets_rounded,
      'group': Icons.group_rounded,
    };
    return map[name] ?? Icons.circle;
  }
}

class _UserTile extends StatelessWidget {
  final dynamic user;
  const _UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          GradientIconBox(
            icon: HomeScreen._getActivityIcon(user.avatarIcon ?? 'group'),
            gradientType: user.gradientType,
            size: 48,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.nickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                const SizedBox(height: 2),
                Text(
                  '${user.activityLabel} · "${user.statusMessage}"',
                  style: const TextStyle(fontSize: 12, color: CrownyTheme.textMuted),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${user.distanceMeters}m', style: const TextStyle(fontSize: 10, color: CrownyTheme.textMuted, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              GradientButton(text: '손흔들기', icon: Icons.waving_hand_rounded, isSmall: true, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

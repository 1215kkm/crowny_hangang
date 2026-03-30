import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';
import '../../widgets/gradient_button.dart';

class MatchingScreen extends StatelessWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const MatchingScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final user = MockData.nearbyUsers[0]; // 첫 번째 사용자를 카드로 표시

    return PurpleScaffold(
      title: '매칭',
      leading: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
      ),
      trailing: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
      ),
      topContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CrownyTheme.pagePadding),
        child: Column(
          children: [
            // 탭
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 2))],
                      ),
                      child: Center(child: Text('추천', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.primary))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: Text('근처', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white.withValues(alpha: 0.75)))),
                    ),
                  ),
                ],
              ),
            ),

            // 사용량 바
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('오늘 손흔들기 2회', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white.withValues(alpha: 0.9))),
                      Text('남은 3회', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white.withValues(alpha: 0.9))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: 0.4,
                      minHeight: 5,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
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
          const SizedBox(height: 12),

          // 프로필 카드
          Row(
            children: [
              GradientIconBox(icon: Icons.directions_run_rounded, gradientType: user.gradientType, size: 60, iconSize: 30, borderRadius: 18),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.nickname, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, size: 14, color: CrownyTheme.textMuted),
                        const SizedBox(width: 4),
                        Text('${user.distanceMeters}m · ${user.activityLabel}', style: const TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: CrownyTheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_rounded, size: 14, color: CrownyTheme.primary),
                    const SizedBox(width: 3),
                    Text('Lv.${user.trustLevel}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CrownyTheme.primary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 한줄 소개
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 16),
            decoration: BoxDecoration(
              color: CrownyTheme.bgCard,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              '"${user.statusMessage}" 5km 가볍게 뛰고 편의점 라면 ㄱㄱ 🍜',
              style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.6),
            ),
          ),
          const SizedBox(height: 18),

          // 매너 태그
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MannerTag(icon: Icons.schedule_rounded, text: '시간 잘 지켜요', color: const Color(0xFFE11D48)),
              _MannerTag(icon: Icons.chat_rounded, text: '대화 재밌어요', color: CrownyTheme.primary),
              _MannerTag(icon: Icons.local_fire_department_rounded, text: '분위기 메이커', color: const Color(0xFF0284C7)),
            ],
          ),
          const SizedBox(height: 18),

          // 한강 온도
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: CrownyTheme.bgCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.thermostat_rounded, size: 24, color: CrownyTheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('한강 온도', style: TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: (user.hangangTemp - 36.0) / 5.0,
                          minHeight: 5,
                          backgroundColor: const Color(0xFFEDE9FE),
                          valueColor: AlwaysStoppedAnimation(CrownyTheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text('${user.hangangTemp}°', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: CrownyTheme.accent)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 액션 버튼
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.close_rounded, size: 20, color: CrownyTheme.textMuted),
                        SizedBox(width: 6),
                        Text('다음에', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textMuted)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: GradientButton(text: '손흔들기', icon: Icons.waving_hand_rounded, onTap: () {})),
            ],
          ),
        ],
      ),
      bottomNav: CrownyBottomNav(currentIndex: navIndex, onTap: onNavTap),
    );
  }
}

class _MannerTag extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _MannerTag({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 5),
          Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}

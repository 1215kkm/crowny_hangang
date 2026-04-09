import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../config/app_config.dart';
import '../../models/user_model.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/gradient_button.dart';

/// 타인 프로필 상세 화면
class UserProfileScreen extends StatelessWidget {
  final UserModel user;
  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return PurpleScaffold(
      title: '프로필',
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 40, height: 40,
          decoration: CrownyTheme.iconButtonDecoration,
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
        ),
      ),
      topContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.person_rounded, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(user.nickname, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                  if (user.recentMoimTitle != null) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                      child: Text(AppConfig.nearbyBadgeText, style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ]),
                const SizedBox(height: 4),
                Text('${user.activityLabel} · ${user.distanceMeters}m', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8))),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.shield_rounded, size: 14, color: Colors.white),
                const SizedBox(width: 3),
                Text('신뢰 ${user.trustScore}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
              ]),
            ),
          ],
        ),
      ),
      sheetContent: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 한줄 소개
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 16),
          decoration: BoxDecoration(color: const Color(0xFFF3F0FF), borderRadius: BorderRadius.circular(18)),
          child: Text(user.statusMessage, style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.6)),
        ),
        const SizedBox(height: 14),

        // 매너 태그
        Wrap(spacing: 8, runSpacing: 8, children: user.mannerTags.map((t) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(color: CrownyTheme.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12)),
          child: Text(t, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CrownyTheme.primary)),
        )).toList()),
        const SizedBox(height: 14),

        // 한강 온도
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: CrownyTheme.bgCard, borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            Icon(Icons.thermostat_rounded, size: 22, color: CrownyTheme.primary),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('한강 온도', style: TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(value: ((user.hangangTemp - 36) / 10).clamp(0.0, 1.0), minHeight: 5, backgroundColor: const Color(0xFFEDE9FE), valueColor: AlwaysStoppedAnimation(CrownyTheme.primary)),
              ),
            ])),
            const SizedBox(width: 12),
            Text('${user.hangangTemp}°', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: CrownyTheme.accent)),
          ]),
        ),
        const SizedBox(height: 14),

        // 최근 모임
        if (user.recentMoimTitle != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFF3F0FF), borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.groups_rounded, size: 12, color: CrownyTheme.primary),
              const SizedBox(width: 3),
              Text(user.recentMoimTitle!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: CrownyTheme.primary)),
            ]),
          ),
        const SizedBox(height: 20),

        // 버튼
        Row(children: [
          Expanded(child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(14)),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.close_rounded, size: 18, color: CrownyTheme.textMuted),
                SizedBox(width: 6),
                Text('다음에', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textMuted)),
              ]),
            ),
          )),
          const SizedBox(width: 10),
          Expanded(child: GradientButton(text: '손흔들기', icon: Icons.waving_hand_rounded, onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('손흔들기를 보냈습니다! 👋')));
          })),
        ]),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: DM 시작
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('1:1 메시지 (준비 중)')));
            },
            icon: const Icon(Icons.chat_rounded, size: 18),
            label: const Text('1:1 메시지 보내기'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ]),
    );
  }
}

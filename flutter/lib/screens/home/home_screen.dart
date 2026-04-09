import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const HomeScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ── 상단 배경이미지 영역 (570px) ──
              Stack(
                children: [
                  // 배경 이미지
                  Container(
                    width: double.infinity,
                    height: 570,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/home_bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                      // 이미지 로드 실패 시 폴백 그라데이션
                      gradient: CrownyTheme.bgGradient,
                    ),
                    // 이미지 위에 약간의 어두운 오버레이 (글자 가독성)
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.15),
                            Colors.black.withValues(alpha: 0.05),
                            Colors.transparent,
                            Colors.white.withValues(alpha: 0.3),
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // 상단 버튼 (햄버거 + 검색)
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 12,
                    left: 24,
                    right: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/search'),
                          child: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.search_rounded, color: Colors.white, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 중앙 타이틀 텍스트
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '한강앱',
                            style: TextStyle(
                              fontFamily: 'Paperlogy',
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -1,
                              shadows: [
                                Shadow(color: Color(0x40000000), blurRadius: 12, offset: Offset(0, 4)),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hangang App',
                            style: TextStyle(
                              fontFamily: 'Paperlogy',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 1,
                              shadows: [
                                Shadow(color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 2)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ── 하단 흰색 콘텐츠 (둥근 모서리로 올라옴) ──
              Transform.translate(
                offset: const Offset(0, -32),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(CrownyTheme.radiusXl)),
                  ),
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 100),
                  child: Column(
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

                      const SizedBox(height: 20),

                      // 한강 게시판 바로가기
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/board'),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFFF3F0FF), Color(0xFFEDE9FE)]),
                            borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
                            border: Border.all(color: const Color(0xFFDDD6FE)),
                          ),
                          child: Row(
                            children: [
                              const GradientIconBox(icon: Icons.forum_rounded, gradientType: 'purple', size: 42, iconSize: 22, borderRadius: 14),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('한강 게시판', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.primary)),
                                    const Text('지역별 커뮤니티 · 정보 · 맛집 · 사진', style: TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right_rounded, color: CrownyTheme.primary, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 한강 주문 바로가기
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/commerce'),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFFFFF7ED), Color(0xFFFEF3C7)]),
                            borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Row(
                            children: [
                              const GradientIconBox(icon: Icons.delivery_dining_rounded, gradientType: 'orange', size: 42, iconSize: 22, borderRadius: 14),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('한강 주문', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
                                    Text('배달 · 편의점 · 선물하기', style: TextStyle(fontSize: 11, color: Color(0xFFB45309))),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right_rounded, color: const Color(0xFFD97706), size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CrownyBottomNav(currentIndex: navIndex, onTap: onNavTap),
      ),
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

import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../models/user_model.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';

class MatchingScreen extends StatefulWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;
  const MatchingScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  String _district = '전체';
  String _hobby = '전체';
  String _interest = '전체';
  String _mode = 'play';

  static const _districts = ['전체', '여의도', '뚝섬', '반포', '잠실', '망원', '이촌'];
  static const _hobbies = ['전체', '치맥', '러닝', '산책', '피크닉', '반려동물', '자전거', '사진', '카페'];
  static const _interests = ['전체', '맛집탐방', '야경', '음악', '언어교환', '독서', '운동'];

  List<UserModel> get _filtered {
    return MockData.nearbyUsers.where((u) {
      if (u.mood != _mode) return false;
      if (_district != '전체' && !u.statusMessage.contains(_district) && u.recentMoimTitle?.contains(_district) != true) {
        // 간단 mock 필터: district 필드 없으므로 nickname/moim에서 추론
        return true; // mock에서는 전부 보여줌
      }
      if (_hobby != '전체' && !u.hobbies.contains(_hobby)) return false;
      if (_interest != '전체' && !u.interests.contains(_interest)) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final users = _filtered;

    return PurpleScaffold(
      title: '매칭',
      leading: GestureDetector(
        onTap: () => widget.onNavTap(0),
        child: Container(
          width: 40, height: 40,
          decoration: CrownyTheme.iconButtonDecoration,
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
        ),
      ),
      trailing: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
      ),
      topContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 총 접속자 수
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Column(
              children: [
                Text('${MockData.totalOnline}', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1)),
                const SizedBox(height: 2),
                Text('현재 한강에 접속 중', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.7))),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 지역 필터
          _FilterLabel('지역'),
          _ChipRow(items: _districts, selected: _district, onSelect: (v) => setState(() => _district = v)),
          const SizedBox(height: 8),

          // 취미 필터
          _FilterLabel('취미'),
          _ChipRow(items: _hobbies, selected: _hobby, onSelect: (v) => setState(() => _hobby = v)),
          const SizedBox(height: 8),

          // 관심사 필터
          _FilterLabel('관심사'),
          _ChipRow(items: _interests, selected: _interest, onSelect: (v) => setState(() => _interest = v)),
          const SizedBox(height: 8),

          // 모드 토글
          _FilterLabel('모드'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                _ModeBtn(label: '같이 놀래요 🎉', active: _mode == 'play', onTap: () => setState(() => _mode = 'play')),
                _ModeBtn(label: '혼자 있을래요 😌', active: _mode == 'alone', onTap: () => setState(() => _mode = 'alone')),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      sheetContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('필터 결과 ', style: TextStyle(fontSize: 12, color: CrownyTheme.textMuted, fontWeight: FontWeight.w600)),
              Text('${users.length}', style: TextStyle(fontSize: 12, color: CrownyTheme.primary, fontWeight: FontWeight.w700)),
              Text('명', style: TextStyle(fontSize: 12, color: CrownyTheme.textMuted, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          if (users.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Icon(Icons.search_off_rounded, size: 48, color: CrownyTheme.textMuted),
                    const SizedBox(height: 12),
                    Text('조건에 맞는 사용자가 없어요\n필터를 변경해보세요', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: CrownyTheme.textMuted)),
                  ],
                ),
              ),
            )
          else
            ...users.map((u) => _UserItem(user: u, onTap: () {
              Navigator.pushNamed(context, '/user-profile', arguments: u);
            })),
        ],
      ),
      bottomNav: CrownyBottomNav(currentIndex: widget.navIndex, onTap: widget.onNavTap),
    );
  }
}

class _FilterLabel extends StatelessWidget {
  final String text;
  const _FilterLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 6),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.6))),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final List<String> items;
  final String selected;
  final ValueChanged<String> onSelect;
  const _ChipRow({required this.items, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final active = items[i] == selected;
          return GestureDetector(
            onTap: () => onSelect(items[i]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: active ? Colors.white : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: active ? Colors.white : Colors.white.withValues(alpha: 0.3)),
              ),
              child: Text(items[i], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? CrownyTheme.primary : Colors.white.withValues(alpha: 0.8))),
            ),
          );
        },
      ),
    );
  }
}

class _ModeBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _ModeBtn({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: active ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))] : null,
          ),
          child: Center(child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: active ? CrownyTheme.primary : Colors.white.withValues(alpha: 0.7)))),
        ),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  const _UserItem({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GradientIconBox(icon: _iconData(user.avatarIcon), gradientType: user.gradientType, size: 48, iconSize: 24, borderRadius: 16),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(user.nickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: CrownyTheme.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(6)),
                            child: Text('신뢰 ${user.trustScore}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: CrownyTheme.primary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text('${user.activityLabel} · ${user.distanceMeters}m', style: const TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
                    ],
                  ),
                ),
                Text('${user.distanceMeters}m', style: const TextStyle(fontSize: 10, color: Color(0xFFD1D5DB), fontWeight: FontWeight.w500)),
              ],
            ),
            if (user.recentMoimTitle != null)
              Padding(
                padding: const EdgeInsets.only(left: 62, top: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFF3F0FF), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.groups_rounded, size: 12, color: CrownyTheme.primary),
                      const SizedBox(width: 3),
                      Text(user.recentMoimTitle!, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: CrownyTheme.primary)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _iconData(String? name) {
    switch (name) {
      case 'directions_run': return Icons.directions_run_rounded;
      case 'sports_bar': return Icons.sports_bar_rounded;
      case 'photo_camera': return Icons.photo_camera_rounded;
      case 'pets': return Icons.pets_rounded;
      case 'local_cafe': return Icons.local_cafe_rounded;
      case 'pedal_bike': return Icons.pedal_bike_rounded;
      default: return Icons.person_rounded;
    }
  }
}

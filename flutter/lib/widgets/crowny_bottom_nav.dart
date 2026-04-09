import 'package:flutter/material.dart';
import '../app/theme.dart';

class CrownyBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CrownyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(icon: Icons.home_rounded, label: '홈'),
    _NavItem(icon: Icons.waving_hand_rounded, label: '매칭'),
    _NavItem(icon: Icons.forum_rounded, label: '채팅'),
    _NavItem(icon: Icons.article_rounded, label: '게시판'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final isActive = i == currentIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: isActive
                            ? BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    CrownyTheme.primary.withValues(alpha: 0.1),
                                    CrownyTheme.secondary.withValues(alpha: 0.06),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              )
                            : null,
                        child: Icon(
                          item.icon,
                          size: 24,
                          color: isActive ? CrownyTheme.primary : CrownyTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isActive ? CrownyTheme.primary : CrownyTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

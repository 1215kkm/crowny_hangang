import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../config/app_config.dart';

/// 햄버거 메뉴 사이드 드로어
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // 헤더
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 24, left: 24, right: 24, bottom: 20),
            decoration: BoxDecoration(gradient: AppConfig.backgroundGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                  ),
                  child: const Icon(Icons.person_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 12),
                const Text('한강탐험가', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                Row(
                  children: [
                    const Icon(Icons.shield_rounded, size: 14, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text('신뢰도 78', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.8))),
                  ],
                ),
              ],
            ),
          ),

          // 메뉴
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _DrawerItem(icon: Icons.person_rounded, label: '프로필', onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                }),
                _DrawerItem(icon: Icons.map_rounded, label: '${AppConfig.appName} 지도', onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/map');
                }),
                const Divider(height: 16, indent: 24, endIndent: 24),
                _DrawerItem(icon: Icons.login_rounded, label: '로그인', onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth');
                }),
                _DrawerItem(icon: Icons.person_add_rounded, label: '회원가입', onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth');
                }),
                const Divider(height: 16, indent: 24, endIndent: 24),
                _DrawerItem(icon: Icons.settings_rounded, label: '설정', onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                }),
              ],
            ),
          ),

          // 글자크기 + 로그아웃
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF3F4F6)))),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('글자크기', style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w600)),
                    const Spacer(),
                    _FontSizeBtn(label: '−', delta: -1),
                    const SizedBox(width: 8),
                    _FontSizeBtn(label: '+', delta: 1),
                  ],
                ),
                const SizedBox(height: 8),
                _DrawerItem(icon: Icons.logout_rounded, label: '로그아웃', color: const Color(0xFF9CA3AF), onTap: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const _DrawerItem({required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 22, color: color ?? CrownyTheme.primary),
      title: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color ?? CrownyTheme.textPrimary)),
      onTap: onTap,
      dense: true,
    );
  }
}

class _FontSizeBtn extends StatelessWidget {
  final String label;
  final int delta;
  const _FontSizeBtn({required this.label, required this.delta});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: SharedPreferences로 글자크기 조절
      },
      child: Container(
        width: 40, height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary))),
      ),
    );
  }
}

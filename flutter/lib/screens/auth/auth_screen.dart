import 'package:flutter/material.dart';
import '../../app/theme.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: CrownyTheme.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(CrownyTheme.pagePadding),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // 로고
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.water_rounded, size: 44, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Crowny',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '한강에서 새로운 인연을 만나세요',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),

                const Spacer(flex: 3),

                // 카카오 로그인
                _LoginButton(
                  text: '카카오로 시작하기',
                  icon: Icons.chat_bubble_rounded,
                  color: const Color(0xFFFEE500),
                  textColor: const Color(0xFF191919),
                  onTap: () => Navigator.pushReplacementNamed(context, '/main'),
                ),
                const SizedBox(height: 12),

                // 구글 로그인
                _LoginButton(
                  text: 'Google로 시작하기',
                  icon: Icons.g_mobiledata_rounded,
                  color: Colors.white,
                  textColor: CrownyTheme.textPrimary,
                  onTap: () => Navigator.pushReplacementNamed(context, '/main'),
                ),
                const SizedBox(height: 12),

                // Apple 로그인
                _LoginButton(
                  text: 'Apple로 시작하기',
                  icon: Icons.apple_rounded,
                  color: Colors.black,
                  textColor: Colors.white,
                  onTap: () => Navigator.pushReplacementNamed(context, '/main'),
                ),

                const SizedBox(height: 24),
                Text(
                  '계속 진행하면 이용약관 및 개인정보처리방침에 동의합니다',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _LoginButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 22),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

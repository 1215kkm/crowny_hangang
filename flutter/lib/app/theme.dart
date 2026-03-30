import 'package:flutter/material.dart';

/// Style D 디자인 토큰 — 보라 그라데이션 + Material Icons + 흰 바텀시트
class CrownyTheme {
  CrownyTheme._();

  // ── 메인 색상 ──
  static const Color primary = Color(0xFF6C3CE1);
  static const Color primaryLight = Color(0xFF7C4DFF);
  static const Color primaryDark = Color(0xFF5B2FD6);
  static const Color secondary = Color(0xFFD63384);
  static const Color accent = Color(0xFFE8590C);
  static const Color cyan = Color(0xFF0EA5E9);
  static const Color green = Color(0xFF059669);

  // ── 배경 ──
  static const Color bgPurple = Color(0xFF5B2FD6);
  static const Color bgSheet = Color(0xFFFFFFFF);
  static const Color bgCard = Color(0xFFF9F7FF);
  static const Color bgPage = Color(0xFFF3F0FF);

  // ── 텍스트 ──
  static const Color textPrimary = Color(0xFF1E1B4B);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textOnPurple = Color(0xFFFFFFFF);

  // ── 상태 색상 ──
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // ── 그라데이션 ──
  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5B2FD6), Color(0xFF7C4DFF), Color(0xFF9B72FF)],
    stops: [0.0, 0.35, 1.0],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C3CE1), Color(0xFFD63384)],
  );

  // 아이콘 그라데이션
  static const LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF43F5E), Color(0xFFD63384)],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C4DFF), Color(0xFF5B2FD6)],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0EA5E9), Color(0xFF2563EB)],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFE8590C)],
  );

  // ── 보더 ──
  static const double radiusSm = 12.0;
  static const double radiusMd = 18.0;
  static const double radiusLg = 24.0;
  static const double radiusXl = 32.0;
  static const double radiusFull = 9999.0;

  // ── 여백 ──
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingSection = 28.0;
  static const double pagePadding = 24.0;

  // ── 그림자 ──
  static List<BoxShadow> get shadowSm => [
    BoxShadow(
      color: primary.withValues(alpha: 0.06),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowMd => [
    BoxShadow(
      color: primary.withValues(alpha: 0.12),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowLg => [
    BoxShadow(
      color: primary.withValues(alpha: 0.18),
      blurRadius: 30,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get shadowButton => [
    BoxShadow(
      color: primary.withValues(alpha: 0.35),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  // ── 글래스 효과 (보라 배경 위 반투명 카드) ──
  static BoxDecoration get glassDecoration => BoxDecoration(
    color: Colors.white.withValues(alpha: 0.22),
    borderRadius: BorderRadius.circular(radiusLg),
    border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
  );

  static BoxDecoration get glassDecorationLight => BoxDecoration(
    color: Colors.white.withValues(alpha: 0.15),
    borderRadius: BorderRadius.circular(radiusMd),
  );

  // ── 아이콘 버튼 (보라 배경 위) ──
  static BoxDecoration get iconButtonDecoration => BoxDecoration(
    color: Colors.white.withValues(alpha: 0.2),
    borderRadius: BorderRadius.circular(14),
  );

  // ── ThemeData ──
  static ThemeData get themeData => ThemeData(
    useMaterial3: true,
    fontFamily: 'NotoSansKR',
    scaffoldBackgroundColor: bgPage,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      error: error,
      surface: bgSheet,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: textOnPurple,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: textPrimary, height: 1.3),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: textPrimary, height: 1.35),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textPrimary),
      titleLarge: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: textPrimary),
      titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textPrimary),
      titleSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: textPrimary),
      bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
      bodyMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textSecondary),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textSecondary),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textMuted),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: textMuted),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusMd)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: bgCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    ),
  );
}

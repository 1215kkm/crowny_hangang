import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 화이트라벨 앱 설정 — JSON에서 로드, 코드에 주제 하드코딩 금지
class AppConfig {
  AppConfig._();
  static late Map<String, dynamic> _config;
  static bool _loaded = false;

  /// 앱 시작 시 호출 (main.dart의 runApp 전에)
  static Future<void> load({String theme = 'hangang'}) async {
    final json = await rootBundle.loadString('config/themes/$theme.json');
    _config = jsonDecode(json) as Map<String, dynamic>;
    _loaded = true;
  }

  static void _check() { assert(_loaded, 'AppConfig.load()를 먼저 호출하세요'); }

  // ── App ──
  static String get appName { _check(); return _config['app']['name']; }
  static String get appNameEn { _check(); return _config['app']['nameEn']; }
  static String get appDescription { _check(); return _config['app']['description']; }
  static String get logoPath { _check(); return _config['app']['logo']; }
  static String get homeBgPath { _check(); return _config['app']['homeBg']; }

  // ── Theme ──
  static Color get primaryColor => _hexToColor(_config['theme']['primaryColor']);
  static Color get pinkColor => _hexToColor(_config['theme']['pinkColor']);
  static Color get orangeColor => _hexToColor(_config['theme']['orangeColor']);
  static Color get cyanColor => _hexToColor(_config['theme']['cyanColor']);
  static Color get greenColor => _hexToColor(_config['theme']['greenColor']);
  static Color get gradientStart => _hexToColor(_config['theme']['gradientStart']);
  static Color get gradientMid => _hexToColor(_config['theme']['gradientMid']);
  static Color get gradientEnd => _hexToColor(_config['theme']['gradientEnd']);

  static LinearGradient get backgroundGradient => LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [gradientStart, gradientMid, gradientEnd],
  );

  // ── Location ──
  static double get centerLat => (_config['location']['centerLat'] as num).toDouble();
  static double get centerLng => (_config['location']['centerLng'] as num).toDouble();
  static int get nearbyRadius => _config['location']['nearbyRadius'];
  static String get nearbyBadgeText => _config['location']['nearbyBadgeText'];
  static String get mapSvgPath => _config['location']['mapSvg'];

  // ── Districts ──
  static List<Map<String, dynamic>> get districts =>
      (_config['districts'] as List).cast<Map<String, dynamic>>();
  static List<String> get districtNames =>
      districts.map((d) => d['name'] as String).toList();

  // ── Categories ──
  static List<String> get hobbies =>
      (_config['categories']['hobbies'] as List).cast<String>();
  static List<String> get interests =>
      (_config['categories']['interests'] as List).cast<String>();

  // ── Games ──
  static List<List<String>> get balanceQuestions =>
      (_config['games']['balanceQuestions'] as List)
          .map((q) => (q as List).cast<String>())
          .toList();
  static List<String> get presetQuestions =>
      (_config['games']['presetQuestions'] as List).cast<String>();
  static Map<String, List<String>> get charadesCategories =>
      (_config['games']['charadesCategories'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, (v as List).cast<String>()));
  static Map<String, List<String>> get rolePresets =>
      (_config['games']['rolePresets'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, (v as List).cast<String>()));
  static List<String> get choseongList =>
      (_config['games']['choseongList'] as List).cast<String>();

  // ── Board ──
  static String get boardName => _config['board']['name'];
  static List<String> get boardCategories =>
      (_config['board']['categories'] as List).cast<String>();

  // ── Legal ──
  static String get termsUrl => _config['legal']['termsUrl'];
  static String get privacyUrl => _config['legal']['privacyUrl'];

  // ── Helpers ──
  static Color _hexToColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xFF')));
  }
}

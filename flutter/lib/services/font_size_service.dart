import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 글자크기 조절 서비스 — SharedPreferences에 저장, 다음 접속 시 복원
class FontSizeService extends ChangeNotifier {
  static const String _key = 'crowny_font_size_offset';
  static const int _min = -3;
  static const int _max = 6;
  static const int _defaultOffset = 1; // 30대 기준

  int _offset = _defaultOffset;
  int get offset => _offset;
  double get scaleFactor => 1.0 + (_offset * 0.07); // 1단계당 7% 확대

  /// 앱 시작 시 저장된 값 로드
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _offset = prefs.getInt(_key) ?? _defaultOffset;
    notifyListeners();
  }

  /// 글자크기 변경 (+1 또는 -1)
  Future<void> change(int delta) async {
    _offset = (_offset + delta).clamp(_min, _max);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, _offset);
    notifyListeners();
  }
}

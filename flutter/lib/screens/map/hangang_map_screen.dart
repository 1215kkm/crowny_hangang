import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../config/app_config.dart';

/// 한강 일러스트 지도 화면 (SVG 대신 CustomPainter)
class HangangMapScreen extends StatefulWidget {
  const HangangMapScreen({super.key});

  @override
  State<HangangMapScreen> createState() => _HangangMapScreenState();
}

class _HangangMapScreenState extends State<HangangMapScreen> {
  String _selectedDistrict = '';
  final _districtUsers = {'난지': 7, '망원': 9, '양화': 6, '여의도': 23, '이촌': 8, '반포': 15, '뚝섬': 18, '잠실': 12, '광나루': 4};

  @override
  void initState() {
    super.initState();
    _selectedDistrict = AppConfig.districtNames.isNotEmpty ? AppConfig.districtNames[3] : '';
  }

  @override
  Widget build(BuildContext context) {
    final count = _districtUsers[_selectedDistrict] ?? 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        // 헤더
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, bottom: 12, left: 16, right: 16),
          decoration: BoxDecoration(gradient: AppConfig.backgroundGradient),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22)),
            ),
            const SizedBox(width: 12),
            Text('${AppConfig.appName} 지도', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
          ]),
        ),

        // 지도 영역
        Expanded(
          child: InteractiveViewer(
            minScale: 0.5, maxScale: 3.0,
            child: CustomPaint(
              size: const Size(400, 300),
              painter: _MapPainter(
                districts: AppConfig.districtNames,
                districtUsers: _districtUsers,
                selected: _selectedDistrict,
              ),
            ),
          ),
        ),

        // 선택된 지구 정보
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: CrownyTheme.bgCard, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFEDE9FE))),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(_selectedDistrict, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
              Text('$count명 접속 중', style: TextStyle(fontSize: 13, color: CrownyTheme.primary, fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: CrownyTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('이 지구 모임방 보기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text('사용자 위치는 지구 단위로만 표시됩니다', style: TextStyle(fontSize: 11, color: const Color(0xFF9CA3AF))),
        ),
      ]),
    );
  }
}

class _MapPainter extends CustomPainter {
  final List<String> districts;
  final Map<String, int> districtUsers;
  final String selected;
  _MapPainter({required this.districts, required this.districtUsers, required this.selected});

  @override
  void paint(Canvas canvas, Size size) {
    // 배경
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16)), Paint()..color = const Color(0xFFFAFBFF));

    // 한강 물줄기
    final riverPath = Path()..moveTo(0, size.height * 0.5);
    riverPath.cubicTo(size.width * 0.2, size.height * 0.45, size.width * 0.4, size.height * 0.55, size.width * 0.6, size.height * 0.48);
    riverPath.cubicTo(size.width * 0.8, size.height * 0.42, size.width * 0.9, size.height * 0.5, size.width, size.height * 0.47);
    canvas.drawPath(riverPath, Paint()..color = const Color(0xFFBFDBFE)..strokeWidth = 20..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);

    // 지구 마커
    final positions = <String, Offset>{
      '난지': Offset(size.width * 0.1, size.height * 0.35),
      '망원': Offset(size.width * 0.2, size.height * 0.38),
      '양화': Offset(size.width * 0.28, size.height * 0.68),
      '여의도': Offset(size.width * 0.42, size.height * 0.68),
      '이촌': Offset(size.width * 0.5, size.height * 0.32),
      '반포': Offset(size.width * 0.62, size.height * 0.68),
      '뚝섬': Offset(size.width * 0.72, size.height * 0.32),
      '잠실': Offset(size.width * 0.82, size.height * 0.68),
      '광나루': Offset(size.width * 0.92, size.height * 0.35),
    };

    for (final name in districts) {
      final pos = positions[name];
      if (pos == null) continue;
      final users = districtUsers[name] ?? 0;
      final isSelected = name == selected;
      final r = isSelected ? 24.0 : 20.0;

      canvas.drawCircle(pos, r, Paint()..color = isSelected ? const Color(0xFFF3F0FF) : const Color(0xFFF9F7FF));
      canvas.drawCircle(pos, r, Paint()..color = isSelected ? const Color(0xFF7C4DFF) : const Color(0xFFDDD6FE)..style = PaintingStyle.stroke..strokeWidth = 2);

      // 이름
      final tp = TextPainter(text: TextSpan(text: name, style: TextStyle(fontSize: isSelected ? 11 : 10, fontWeight: FontWeight.w800, color: const Color(0xFF1E1B4B))), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy - 6));

      // 인원수
      final tp2 = TextPainter(text: TextSpan(text: '${users}명', style: TextStyle(fontSize: isSelected ? 10 : 9, fontWeight: FontWeight.w700, color: const Color(0xFF6C3CE1))), textDirection: TextDirection.ltr)..layout();
      tp2.paint(canvas, Offset(pos.dx - tp2.width / 2, pos.dy + 5));
    }
  }

  @override
  bool shouldRepaint(covariant _MapPainter old) => old.selected != selected;
}

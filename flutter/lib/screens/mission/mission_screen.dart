import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';
import '../../widgets/gradient_button.dart';
import 'dart:math' as math;

class MissionScreen extends StatefulWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const MissionScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  int _currentPhase = 1; // 0~3
  int _currentMission = 0;
  int _remainingSeconds = 180;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        t.cancel();
        setState(() => _isRunning = false);
      }
    });
  }

  String get _timerText {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  double get _progress => _remainingSeconds / 180;

  @override
  Widget build(BuildContext context) {
    final phases = MockData.missionPhases;
    final currentPhaseData = phases[_currentPhase];
    final currentMissionData = currentPhaseData.missions[_currentMission];

    return PurpleScaffold(
      title: '미션 타이머',
      leading: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
      ),
      trailing: GestureDetector(
        child: Text('나가기', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6))),
      ),
      topContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CrownyTheme.pagePadding),
        child: Column(
          children: [
            // 진행 라벨
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(phases.length, (i) {
                final isActive = i == _currentPhase;
                final isDone = i < _currentPhase;
                return Text(
                  isDone ? '${phases[i].name} ✓' : phases[i].name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isDone
                        ? CrownyTheme.green
                        : isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            // 진행 바
            Row(
              children: List.generate(phases.length, (i) {
                final isActive = i == _currentPhase;
                final isDone = i < _currentPhase;
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i < phases.length - 1 ? 5 : 0),
                    decoration: BoxDecoration(
                      color: isDone
                          ? CrownyTheme.green
                          : isActive
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      sheetContent: Column(
        children: [
          const SizedBox(height: 12),

          // 미션 태그
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: CrownyTheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bolt_rounded, size: 14, color: CrownyTheme.primary),
                const SizedBox(width: 4),
                Text('Phase ${_currentPhase + 1} · ${currentPhaseData.name}',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CrownyTheme.primary)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 미션 아이콘
          GradientIconBox(
            icon: _getMissionIcon(currentMissionData.icon),
            gradientType: 'pink',
            size: 80,
            iconSize: 40,
            borderRadius: 24,
          ),
          const SizedBox(height: 16),

          // 미션 텍스트
          Text(
            currentMissionData.text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary, height: 1.4),
          ),
          const SizedBox(height: 6),
          Text(
            currentMissionData.sub,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: CrownyTheme.textMuted),
          ),
          const SizedBox(height: 24),

          // 타이머
          SizedBox(
            width: 120,
            height: 120,
            child: CustomPaint(
              painter: _TimerPainter(progress: _progress),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_timerText, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: CrownyTheme.textPrimary)),
                    const Text('남은 시간', style: TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // 액션 버튼
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {}, // 스킵
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.refresh_rounded, size: 20, color: CrownyTheme.textMuted),
                        SizedBox(width: 6),
                        Text('다른 미션', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textMuted)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: GradientButton(text: '완료!', icon: Icons.check_circle_rounded, onTap: () {})),
            ],
          ),
          const SizedBox(height: 32),

          // 다음 미션 리스트
          Row(
            children: const [
              Icon(Icons.playlist_play_rounded, size: 18, color: CrownyTheme.primary),
              SizedBox(width: 6),
              Text('다음 미션', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
            ],
          ),
          const SizedBox(height: 14),
          ..._buildNextMissions(phases),
        ],
      ),
      bottomNav: CrownyBottomNav(currentIndex: widget.navIndex, onTap: widget.onNavTap),
    );
  }

  List<Widget> _buildNextMissions(List phases) {
    final items = <Widget>[];
    // 현재 페이즈의 나머지 미션 + 다음 페이즈 미션
    for (var pi = _currentPhase; pi < phases.length && items.length < 3; pi++) {
      for (var mi = 0; mi < phases[pi].missions.length && items.length < 3; mi++) {
        if (pi == _currentPhase && mi <= _currentMission) continue;
        final m = phases[pi].missions[mi];
        final isLocked = pi > _currentPhase;
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Opacity(
              opacity: isLocked ? 0.4 : 1.0,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: CrownyTheme.bgCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    GradientIconBox(
                      icon: _getMissionIcon(m.icon),
                      gradientType: pi == _currentPhase ? 'pink' : pi == _currentPhase + 1 ? 'purple' : 'blue',
                      size: 40,
                      iconSize: 20,
                      borderRadius: 14,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                          const SizedBox(height: 1),
                          Row(
                            children: [
                              Icon(Icons.timer_rounded, size: 13, color: CrownyTheme.textMuted),
                              const SizedBox(width: 3),
                              Text('${m.timerSec ~/ 60}분', style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                              if (isLocked) ...[
                                const SizedBox(width: 6),
                                Text('Phase ${pi + 1}', style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(isLocked ? Icons.lock_rounded : Icons.chevron_right_rounded, size: 18, color: const Color(0xFFD1D5DB)),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return items;
  }

  IconData _getMissionIcon(String name) {
    const map = {
      'chat': Icons.chat_rounded,
      'search': Icons.search_rounded,
      'photo_camera': Icons.photo_camera_rounded,
      'edit': Icons.edit_rounded,
      'lightbulb': Icons.lightbulb_rounded,
      'ramen_dining': Icons.ramen_dining_rounded,
    };
    return map[name] ?? Icons.circle;
  }
}

class _TimerPainter extends CustomPainter {
  final double progress;
  _TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;

    // 배경 링
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = const Color(0xFFEDE9FE),
    );

    // 진행 링
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: const [Color(0xFF6C3CE1), Color(0xFFD63384)],
    );
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round
        ..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _TimerPainter old) => old.progress != progress;
}

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../app/theme.dart';

/// 원형 미션 타이머 위젯 — 채팅방 내에서 재사용
class MissionTimerWidget extends StatefulWidget {
  final int totalSeconds;
  final VoidCallback? onComplete;
  final double size;

  const MissionTimerWidget({
    super.key,
    required this.totalSeconds,
    this.onComplete,
    this.size = 120,
  });

  @override
  State<MissionTimerWidget> createState() => _MissionTimerWidgetState();
}

class _MissionTimerWidgetState extends State<MissionTimerWidget> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.totalSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remaining > 0) {
        setState(() => _remaining--);
      } else {
        t.cancel();
        widget.onComplete?.call();
      }
    });
  }

  String get _timerText {
    final m = _remaining ~/ 60;
    final s = _remaining % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  double get _progress => widget.totalSeconds > 0 ? _remaining / widget.totalSeconds : 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _TimerPainter(progress: _progress),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_timerText, style: TextStyle(fontSize: widget.size * 0.27, fontWeight: FontWeight.w900, color: CrownyTheme.textPrimary)),
              Text('남은 시간', style: TextStyle(fontSize: widget.size * 0.083, color: CrownyTheme.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerPainter extends CustomPainter {
  final double progress;
  _TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;

    canvas.drawCircle(
      center, radius,
      Paint()..style = PaintingStyle.stroke..strokeWidth = 6..color = const Color(0xFFEDE9FE),
    );

    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: 3 * math.pi / 2,
      colors: const [Color(0xFF6C3CE1), Color(0xFFD63384)],
    );
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect, -math.pi / 2, 2 * math.pi * progress, false,
      Paint()..style = PaintingStyle.stroke..strokeWidth = 6..strokeCap = StrokeCap.round..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _TimerPainter old) => old.progress != progress;
}

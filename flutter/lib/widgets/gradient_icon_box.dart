import 'package:flutter/material.dart';
import '../app/theme.dart';

/// 그라데이션 배경 아이콘 박스 (활동, 번개 모임, 사용자 아바타 등에 사용)
class GradientIconBox extends StatelessWidget {
  final IconData icon;
  final String gradientType; // pink, purple, blue, orange
  final double size;
  final double iconSize;
  final double borderRadius;

  const GradientIconBox({
    super.key,
    required this.icon,
    required this.gradientType,
    this.size = 48,
    this.iconSize = 24,
    this.borderRadius = 16,
  });

  LinearGradient get _gradient {
    switch (gradientType) {
      case 'pink':
        return CrownyTheme.pinkGradient;
      case 'purple':
        return CrownyTheme.purpleGradient;
      case 'blue':
        return CrownyTheme.blueGradient;
      case 'orange':
        return CrownyTheme.orangeGradient;
      default:
        return CrownyTheme.purpleGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(icon, color: Colors.white, size: iconSize),
    );
  }
}

import 'package:flutter/material.dart';
import '../app/theme.dart';

/// 보라→핑크 그라데이션 버튼
class GradientButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSmall;

  const GradientButton({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 14 : 24,
          vertical: isSmall ? 7 : 15,
        ),
        decoration: BoxDecoration(
          gradient: CrownyTheme.buttonGradient,
          borderRadius: BorderRadius.circular(isSmall ? 10 : CrownyTheme.radiusMd),
          boxShadow: CrownyTheme.shadowButton,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: isSmall ? 14 : 20),
              SizedBox(width: isSmall ? 4 : 6),
            ],
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isSmall ? 11 : 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

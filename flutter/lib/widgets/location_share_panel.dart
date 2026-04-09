import 'dart:async';
import 'package:flutter/material.dart';
import '../app/theme.dart';

/// 실시간 위치공유 슬라이드 패널 + 플로팅 버튼
class LocationShareController {
  bool isSharing = false;
  Timer? _timer;

  void startSharing() {
    isSharing = true;
    // Mock: 10초마다 위치 전송
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      // TODO: Socket.io로 GPS 좌표 전송
    });
  }

  void stopSharing() {
    isSharing = false;
    _timer?.cancel();
    _timer = null;
  }

  void dispose() => stopSharing();
}

/// 위치공유 플로팅 버튼 (채팅방 위에 표시)
class LocationShareFab extends StatelessWidget {
  final bool visible;
  final VoidCallback onTap;
  const LocationShareFab({super.key, required this.visible, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    return Positioned(
      right: 16, top: MediaQuery.of(context).size.height * 0.5 - 24,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            gradient: CrownyTheme.primaryGradient, shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: CrownyTheme.primary.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 4))],
          ),
          child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

/// 위치공유 슬라이드 패널 (오른쪽에서 슬라이드 인)
class LocationSharePanel extends StatelessWidget {
  final bool open;
  final VoidCallback onClose;
  final VoidCallback onStop;
  const LocationSharePanel({super.key, required this.open, required this.onClose, required this.onStop});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: 0, bottom: 0,
      right: open ? 0 : -(MediaQuery.of(context).size.width * 0.75),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 24, offset: const Offset(-4, 0))],
        ),
        child: Column(children: [
          // 헤더
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 16, right: 8, bottom: 12),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6)))),
            child: Row(children: [
              const Text('📍 실시간 위치', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close_rounded, size: 20), onPressed: onClose),
            ]),
          ),

          // 지도 영역 (Mock SVG 대신 간단한 CustomPaint)
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.map_rounded, size: 48, color: CrownyTheme.primary.withValues(alpha: 0.3)),
                  const SizedBox(height: 8),
                  const Text('내 위치', style: TextStyle(fontSize: 12, color: Color(0xFFD63384), fontWeight: FontWeight.w700)),
                  const Text('여의도 한강공원 근처', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 16),
                  const Text('상대 위치', style: TextStyle(fontSize: 12, color: Color(0xFF2563EB), fontWeight: FontWeight.w700)),
                  const Text('약 200m 거리', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                ]),
              ),
            ),
          ),

          // 하단
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              const Text('10초마다 위치 업데이트', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onStop,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEF2F2),
                    foregroundColor: const Color(0xFFDC2626),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('위치 공유 종료', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

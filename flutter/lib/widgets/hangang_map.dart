import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import '../app/theme.dart';
import '../mock/mock_data.dart';
import '../services/map_service.dart';

/// 한강 지도 위젯 — 카카오맵 + 사용자 마커
class HangangMap extends StatefulWidget {
  final double height;
  final String district;
  final VoidCallback? onExpand;

  const HangangMap({
    super.key,
    this.height = 200,
    this.district = 'yeouido',
    this.onExpand,
  });

  @override
  State<HangangMap> createState() => _HangangMapState();
}

class _HangangMapState extends State<HangangMap> {
  KakaoMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final center = MapService.districts[widget.district] ?? MapService.defaultCenter;

    return ClipRRect(
      borderRadius: BorderRadius.circular(CrownyTheme.radiusLg),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            KakaoMap(
              center: center,
              currentLevel: 4,
              markers: _markers.toList(),
              onMapCreated: (controller) {
                _mapController = controller;
                _addUserMarkers(center);
              },
            ),
            // 확대 버튼
            if (widget.onExpand != null)
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: widget.onExpand,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(CrownyTheme.radiusSm),
                      boxShadow: CrownyTheme.shadowSm,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.fullscreen_rounded, size: 16, color: CrownyTheme.primary),
                        SizedBox(width: 4),
                        Text('지도 확대', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CrownyTheme.primary)),
                      ],
                    ),
                  ),
                ),
              ),
            // 현재 위치 표시 라벨
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: CrownyTheme.primary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: CrownyTheme.shadowSm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.my_location_rounded, size: 12, color: Colors.white),
                    SizedBox(width: 4),
                    Text('내 위치', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addUserMarkers(LatLng center) {
    // 내 위치 마커
    _markers.add(Marker(
      markerId: 'me',
      latLng: center,
    ));

    // 근처 사용자 마커 (Mock — 중심 근처 랜덤 위치)
    for (var i = 0; i < MockData.nearbyUsers.length; i++) {
      final user = MockData.nearbyUsers[i];
      final offset = (i + 1) * 0.001;
      final directions = [
        LatLng(center.latitude + offset, center.longitude - offset),
        LatLng(center.latitude - offset * 0.5, center.longitude + offset),
        LatLng(center.latitude + offset * 0.3, center.longitude + offset * 1.2),
        LatLng(center.latitude - offset * 0.8, center.longitude - offset * 0.5),
      ];

      _markers.add(Marker(
        markerId: user.id,
        latLng: directions[i % directions.length],
      ));
    }

    setState(() {});
  }
}

import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../widgets/gradient_icon_box.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CrownyTheme.bgPage,
      appBar: AppBar(
        title: const Text('이벤트', style: TextStyle(fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(CrownyTheme.pagePadding),
        children: [
          // 탭
          Row(
            children: [
              _FilterChip(label: '번개', isActive: true),
              const SizedBox(width: 8),
              _FilterChip(label: '정기', isActive: false),
              const SizedBox(width: 8),
              _FilterChip(label: '시즌', isActive: false),
              const SizedBox(width: 8),
              _FilterChip(label: '테마', isActive: false),
            ],
          ),
          const SizedBox(height: 20),

          ...MockData.flashEvents.map((e) => _EventCard(event: e)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CrownyTheme.primary,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _FilterChip({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? CrownyTheme.primary : Colors.white,
        borderRadius: BorderRadius.circular(CrownyTheme.radiusFull),
        border: isActive ? null : Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(label, style: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w600,
        color: isActive ? Colors.white : CrownyTheme.textSecondary,
      )),
    );
  }
}

class _EventCard extends StatelessWidget {
  final dynamic event;
  const _EventCard({required this.event});

  static IconData _getIcon(String name) {
    const map = {
      'restaurant': Icons.restaurant_rounded,
      'directions_run': Icons.directions_run_rounded,
      'nightlight': Icons.nightlight_rounded,
    };
    return map[name] ?? Icons.event_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(CrownyTheme.radiusLg),
        boxShadow: CrownyTheme.shadowSm,
      ),
      child: Row(
        children: [
          GradientIconBox(
            icon: _getIcon(event.icon),
            gradientType: event.gradientType,
            size: 52,
            iconSize: 26,
            borderRadius: 16,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: 13, color: CrownyTheme.textMuted),
                    const SizedBox(width: 3),
                    Text(event.location, style: const TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: event.currentPeople / event.maxPeople,
                    minHeight: 4,
                    backgroundColor: const Color(0xFFEDE9FE),
                    valueColor: AlwaysStoppedAnimation(CrownyTheme.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text('${event.currentPeople}/${event.maxPeople}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CrownyTheme.primary)),
              const Text('명', style: TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../models/chat_model.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';
import '../../widgets/gradient_button.dart';

class ChatListScreen extends StatefulWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;
  const ChatListScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String? _expandedRoomId;

  @override
  Widget build(BuildContext context) {
    return PurpleScaffold(
      title: '모임방',
      leading: GestureDetector(
        onTap: () => widget.onNavTap(0),
        child: Container(
          width: 40, height: 40,
          decoration: CrownyTheme.iconButtonDecoration,
          child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
        ),
      ),
      trailing: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/create-room'),
        child: Container(
          width: 40, height: 40,
          decoration: CrownyTheme.iconButtonDecoration,
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 22),
        ),
      ),
      sheetContent: Column(
        children: MockData.moimRooms.map((room) => _RoomTile(
          room: room,
          expanded: _expandedRoomId == room.id,
          onTap: () {
            if (room.isLocked) {
              setState(() => _expandedRoomId = _expandedRoomId == room.id ? null : room.id);
            } else {
              Navigator.pushNamed(context, '/chat-room', arguments: room);
            }
          },
          onWave: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('손흔들기를 보냈습니다! 👋'), duration: Duration(seconds: 2)),
            );
          },
          onClose: () => setState(() => _expandedRoomId = null),
        )).toList(),
      ),
      bottomNav: CrownyBottomNav(currentIndex: widget.navIndex, onTap: widget.onNavTap),
    );
  }
}

class _RoomTile extends StatelessWidget {
  final MoimRoom room;
  final bool expanded;
  final VoidCallback onTap;
  final VoidCallback onWave;
  final VoidCallback onClose;

  const _RoomTile({required this.room, required this.expanded, required this.onTap, required this.onWave, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6)))),
            child: Row(
              children: [
                GradientIconBox(icon: _iconData(room.creatorIcon), gradientType: room.creatorGradient, size: 48, iconSize: 24, borderRadius: 16),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        if (room.isLocked) ...[const Icon(Icons.lock_rounded, size: 16, color: Color(0xFF9CA3AF)), const SizedBox(width: 4)],
                        Expanded(child: Text(room.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary), overflow: TextOverflow.ellipsis)),
                      ]),
                      const SizedBox(height: 2),
                      Text('${room.creatorNickname} · ${room.district} · ${room.currentPeople}/${room.maxPeople}명', style: const TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
                    ],
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  if (room.unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(8)),
                      child: Text('${room.unreadCount}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  if (room.mission != null) ...[
                    const SizedBox(height: 4),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.timer_rounded, size: 13, color: CrownyTheme.accent),
                      const SizedBox(width: 2),
                      Text(room.mission!.title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: CrownyTheme.accent)),
                    ]),
                  ],
                ]),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: _DetailCard(room: room, onWave: onWave, onClose: onClose),
          crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }

  IconData _iconData(String? name) {
    switch (name) {
      case 'sports_bar': return Icons.sports_bar_rounded;
      case 'directions_run': return Icons.directions_run_rounded;
      case 'photo_camera': return Icons.photo_camera_rounded;
      case 'ramen_dining': return Icons.ramen_dining_rounded;
      case 'pedal_bike': return Icons.pedal_bike_rounded;
      case 'pets': return Icons.pets_rounded;
      default: return Icons.groups_rounded;
    }
  }
}

class _DetailCard extends StatelessWidget {
  final MoimRoom room;
  final VoidCallback onWave;
  final VoidCallback onClose;
  const _DetailCard({required this.room, required this.onWave, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final tagColors = [const Color(0xFFE11D48), CrownyTheme.primary, const Color(0xFF0EA5E9)];
    final tagIcons = [Icons.schedule_rounded, Icons.chat_rounded, Icons.local_fire_department_rounded];

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: CrownyTheme.bgCard, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (room.description != null) Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(28, 14, 14, 14),
          decoration: BoxDecoration(color: const Color(0xFFF3F0FF), borderRadius: BorderRadius.circular(16)),
          child: Text(room.description!, style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.5)),
        ),
        const SizedBox(height: 12),
        // 매너 태그
        Wrap(spacing: 8, runSpacing: 8, children: room.creatorTags.asMap().entries.map((e) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(color: tagColors[e.key % 3].withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(tagIcons[e.key % 3], size: 14, color: tagColors[e.key % 3]),
            const SizedBox(width: 4),
            Text(e.value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: tagColors[e.key % 3])),
          ]),
        )).toList()),
        const SizedBox(height: 12),
        // 한강 온도
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: CrownyTheme.bgCard, borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            Icon(Icons.thermostat_rounded, size: 22, color: CrownyTheme.primary),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('한강 온도', style: TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(value: ((room.creatorTemp - 36) / 10).clamp(0.0, 1.0), minHeight: 5, backgroundColor: const Color(0xFFEDE9FE), valueColor: AlwaysStoppedAnimation(CrownyTheme.primary)),
              ),
            ])),
            const SizedBox(width: 12),
            Text('${room.creatorTemp}°', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: CrownyTheme.accent)),
          ]),
        ),
        const SizedBox(height: 12),
        if (room.mission != null) Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: CrownyTheme.accent.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Icon(_missionIcon(room.mission!.missionType), size: 18, color: CrownyTheme.accent),
            const SizedBox(width: 8),
            Text('${room.mission!.title} · ${room.mission!.timerSec ~/ 60}분', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CrownyTheme.accent)),
          ]),
        ),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: GestureDetector(
            onTap: onClose,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(14)),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.close_rounded, size: 18, color: CrownyTheme.textMuted),
                SizedBox(width: 6),
                Text('닫기', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textMuted)),
              ]),
            ),
          )),
          const SizedBox(width: 10),
          Expanded(child: GradientButton(text: '손흔들기', icon: Icons.waving_hand_rounded, onTap: onWave)),
        ]),
      ]),
    );
  }

  IconData _missionIcon(String type) {
    switch (type) {
      case 'selfie': return Icons.photo_camera_rounded;
      case 'find_unusual': return Icons.search_rounded;
      case 'voice_intro': return Icons.mic_rounded;
      default: return Icons.timer_rounded;
    }
  }
}

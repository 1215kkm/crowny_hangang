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
  String _filter = 'all'; // all, joined, dm

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
      topContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            _FilterBtn(label: '📋 전체', active: _filter == 'all', onTap: () => setState(() => _filter = 'all')),
            _FilterBtn(label: '✅ 참여중', active: _filter == 'joined', onTap: () => setState(() => _filter = 'joined')),
            _FilterBtn(label: '💬 1:1', active: _filter == 'dm', onTap: () => setState(() => _filter = 'dm')),
          ]),
        ),
      ),
      sheetContent: _filter == 'dm' ? _buildDmList() : Column(
        children: (_filter == 'joined' ? MockData.moimRooms.where((r) => r.isJoined).toList() : MockData.moimRooms).map((room) => _RoomTile(
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

  Widget _buildDmList() {
    final dms = MockData.dmRooms;
    if (dms.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('1:1 대화가 없습니다', style: TextStyle(color: Color(0xFF9CA3AF)))));
    return Column(
      children: dms.map((dm) => Dismissible(
        key: Key(dm.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          color: const Color(0xFFDC2626),
          child: const Text('나가기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        ),
        confirmDismiss: (_) => showDialog<bool>(context: context, builder: (_) => AlertDialog(
          title: const Text('대화 나가기'), content: const Text('이 대화를 나가시겠습니까?'),
          actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('취소')), TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('나가기'))],
        )),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/dm-room', arguments: dm.partnerNickname),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6)))),
            child: Row(children: [
              Container(width: 24, height: 24, decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.person_rounded, size: 14, color: Colors.white)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(dm.partnerNickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                if (dm.lastMessage != null) Text(dm.lastMessage!, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                if (dm.lastTime != null) Text(dm.lastTime!, style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                if (dm.unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(8)),
                    child: Text('${dm.unreadCount}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ],
              ]),
            ]),
          ),
        ),
      )).toList(),
    );
  }
}

class _FilterBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _FilterBtn({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: active ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)] : null,
        ),
        child: Center(child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: active ? CrownyTheme.primary : Colors.white.withValues(alpha: 0.7)))),
      ),
    ));
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

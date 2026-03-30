import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_data.dart';
import '../../widgets/purple_scaffold.dart';
import '../../widgets/crowny_bottom_nav.dart';
import '../../widgets/gradient_icon_box.dart';

class ChatListScreen extends StatelessWidget {
  final int navIndex;
  final ValueChanged<int> onNavTap;

  const ChatListScreen({super.key, required this.navIndex, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return PurpleScaffold(
      title: '채팅',
      leading: Container(
        width: 40, height: 40,
        decoration: CrownyTheme.iconButtonDecoration,
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
      ),
      trailing: const SizedBox(width: 40),
      topContent: const SizedBox(height: 12),
      sheetContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          if (MockData.chatRooms.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(Icons.chat_bubble_outline_rounded, size: 48, color: CrownyTheme.textMuted),
                    const SizedBox(height: 12),
                    const Text('아직 채팅이 없어요', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: CrownyTheme.textMuted)),
                    const SizedBox(height: 4),
                    const Text('매칭 후 대화를 시작해보세요!', style: TextStyle(fontSize: 13, color: CrownyTheme.textMuted)),
                  ],
                ),
              ),
            )
          else
            ...MockData.chatRooms.map((room) {
              final timeAgo = DateTime.now().difference(room.lastMessageTime).inMinutes;
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
                  ),
                  child: Row(
                    children: [
                      GradientIconBox(
                        icon: _getIcon(room.partnerIcon),
                        gradientType: room.partnerGradient,
                        size: 50,
                        iconSize: 24,
                        borderRadius: 16,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(room.partnerNickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                                if (room.isActive) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 6, height: 6,
                                    decoration: const BoxDecoration(color: CrownyTheme.green, shape: BoxShape.circle),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              room.lastMessage,
                              style: const TextStyle(fontSize: 13, color: CrownyTheme.textMuted),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${timeAgo}분 전', style: const TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
                          if (room.unreadCount > 0) ...[
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                gradient: CrownyTheme.buttonGradient,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('${room.unreadCount}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
      bottomNav: CrownyBottomNav(currentIndex: navIndex, onTap: onNavTap),
    );
  }

  IconData _getIcon(String name) {
    const map = {
      'sports_bar': Icons.sports_bar_rounded,
      'photo_camera': Icons.photo_camera_rounded,
      'directions_run': Icons.directions_run_rounded,
      'pets': Icons.pets_rounded,
    };
    return map[name] ?? Icons.person_rounded;
  }
}

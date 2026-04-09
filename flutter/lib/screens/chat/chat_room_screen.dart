import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../models/chat_model.dart';
import '../../mock/mock_data.dart';
import '../../widgets/mission_timer.dart';

/// 그룹 채팅방 화면
class ChatRoomScreen extends StatefulWidget {
  final MoimRoom room;
  const ChatRoomScreen({super.key, required this.room});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = List.from(MockData.mockMessages);
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(id: 'new_${_messages.length}', senderId: 'me', senderNickname: '나', text: text, timestamp: DateTime.now(), isMe: true));
    });
    _controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.room;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 헤더
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, bottom: 12),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF5B2FD6), const Color(0xFF7C4DFF)])),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(children: [
                  Text(r.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text('${r.currentPeople}/${r.maxPeople}명', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.7))),
                ]),
                Positioned(left: 16, child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
                  ),
                )),
                Positioned(right: 16, child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 22),
                )),
              ],
            ),
          ),

          // 미션 카드
          if (r.mission != null)
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xFFFFF7ED), border: Border.all(color: const Color(0xFFFDE68A)), borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(gradient: CrownyTheme.primaryGradient, borderRadius: BorderRadius.circular(14)),
                  child: Icon(_missionIcon(r.mission!.missionType), size: 22, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r.mission!.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
                  Text('${r.mission!.timerSec ~/ 60}분', style: const TextStyle(fontSize: 11, color: Color(0xFFB45309))),
                ])),
                MissionTimerWidget(totalSeconds: r.mission!.timerSec, size: 48),
              ]),
            ),

          // 메시지 영역
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _MessageBubble(message: _messages[i]),
            ),
          ),

          // 입력바
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF3F4F6)))),
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  // TODO: +메뉴 바텀시트
                },
                child: Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(color: const Color(0xFFF3F4F6), shape: BoxShape.circle),
                  child: const Icon(Icons.add_circle_rounded, size: 22, color: Color(0xFF6B7280)),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _send(),
                  decoration: InputDecoration(
                    hintText: '메시지 입력...',
                    hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: _send,
                child: Container(
                  width: 42, height: 42,
                  decoration: BoxDecoration(gradient: CrownyTheme.primaryGradient, shape: BoxShape.circle),
                  child: const Icon(Icons.send_rounded, size: 22, color: Colors.white),
                ),
              ),
            ]),
          ),
        ],
      ),
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

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.system) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(20)),
          child: Text(message.text, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500)),
        ),
      );
    }

    if (message.isMe) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(gradient: CrownyTheme.primaryGradient, borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18), bottomLeft: Radius.circular(18), bottomRight: Radius.circular(4))),
              child: Text(message.text, style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.5)),
            ),
            const SizedBox(height: 2),
            Text(_formatTime(message.timestamp), style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
          ]),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.person_rounded, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(message.senderNickname, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF4B5563))),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(18), bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18))),
            child: Text(message.text, style: const TextStyle(fontSize: 13, color: CrownyTheme.textPrimary, height: 1.5)),
          ),
          const SizedBox(height: 2),
          Text(_formatTime(message.timestamp), style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
        ])),
      ]),
    );
  }

  String _formatTime(DateTime t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}';
}

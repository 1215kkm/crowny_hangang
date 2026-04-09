import 'package:flutter/material.dart';
import '../../app/theme.dart';

/// 1:1 DM 채팅방 화면
class DmRoomScreen extends StatefulWidget {
  final String partnerName;
  const DmRoomScreen({super.key, required this.partnerName});

  @override
  State<DmRoomScreen> createState() => _DmRoomScreenState();
}

class _DmRoomScreenState extends State<DmRoomScreen> {
  final _controller = TextEditingController();
  final _messages = <_DmMsg>[
    _DmMsg('안녕하세요! 반갑습니다 👋', false),
    _DmMsg('안녕하세요! 한강 자주 오시나요?', true),
  ];

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _messages.add(_DmMsg(text, true)));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        // 헤더
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, bottom: 12),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF5B2FD6), const Color(0xFF7C4DFF)])),
          child: Stack(alignment: Alignment.center, children: [
            Column(children: [
              Text(widget.partnerName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
              Text('온라인', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.7))),
            ]),
            Positioned(left: 16, child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22)),
            )),
          ]),
        ),

        // 메시지
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (_, i) {
              final m = _messages[i];
              if (m.isMe) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(gradient: CrownyTheme.primaryGradient, borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18), bottomLeft: Radius.circular(18), bottomRight: Radius.circular(4))),
                    child: Text(m.text, style: const TextStyle(fontSize: 13, color: Colors.white)),
                  ),
                );
              }
              return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(width: 32, height: 32, decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.person_rounded, size: 16, color: Colors.white)),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(18), bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18))),
                  child: Text(m.text, style: const TextStyle(fontSize: 13, color: CrownyTheme.textPrimary)),
                ),
              ]);
            },
          ),
        ),

        // 입력바
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFF3F4F6)))),
          child: Row(children: [
            Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFF3F4F6), shape: BoxShape.circle), child: const Icon(Icons.add_circle_rounded, size: 22, color: Color(0xFF6B7280))),
            const SizedBox(width: 6),
            Expanded(child: TextField(
              controller: _controller, onSubmitted: (_) => _send(),
              decoration: InputDecoration(hintText: '메시지 입력...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Color(0xFFD1D5DB))), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), isDense: true),
              style: const TextStyle(fontSize: 14),
            )),
            const SizedBox(width: 6),
            GestureDetector(onTap: _send, child: Container(width: 42, height: 42, decoration: BoxDecoration(gradient: CrownyTheme.primaryGradient, shape: BoxShape.circle), child: const Icon(Icons.send_rounded, size: 22, color: Colors.white))),
          ]),
        ),
      ]),
    );
  }
}

class _DmMsg {
  final String text;
  final bool isMe;
  _DmMsg(this.text, this.isMe);
}

import 'package:flutter/material.dart';
import '../app/theme.dart';

/// 채팅방 [+] 버튼 → 바텀시트 메뉴 (16개 항목)
class ChatPlusMenu extends StatelessWidget {
  final VoidCallback? onLocationShare;
  final VoidCallback? onPoll;
  final VoidCallback? onDutchPay;
  final VoidCallback? onPhoto;
  final VoidCallback? onRandomOrder;
  final VoidCallback? onRandomQuestion;
  final VoidCallback? onBalance;
  final VoidCallback? onRoleAssign;
  final VoidCallback? onSeatShuffle;
  final VoidCallback? onDrawLots;
  final VoidCallback? onNunchi;
  final VoidCallback? onChoseong;
  final VoidCallback? onUpdown;
  final VoidCallback? onCharades;

  const ChatPlusMenu({
    super.key,
    this.onLocationShare, this.onPoll, this.onDutchPay, this.onPhoto,
    this.onRandomOrder, this.onRandomQuestion, this.onBalance, this.onRoleAssign,
    this.onSeatShuffle, this.onDrawLots, this.onNunchi, this.onChoseong,
    this.onUpdown, this.onCharades,
  });

  static void show(BuildContext context, {ChatPlusMenu? menu}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => menu ?? const ChatPlusMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 36, height: 4, margin: const EdgeInsets.only(top: 12, bottom: 8), decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(2))),
        Flexible(
          child: ListView(shrinkWrap: true, children: [
            _PlusItem(icon: '🖼️', label: '사진 선택', onTap: () { Navigator.pop(context); onPhoto?.call(); }),
            _PlusItem(icon: '📷', label: '사진 찍기', onTap: () { Navigator.pop(context); }),
            const _Section('도구'),
            _PlusItem(icon: '📍', label: '위치 공유', onTap: () { Navigator.pop(context); onLocationShare?.call(); }),
            _PlusItem(icon: '📊', label: '투표 만들기', onTap: () { Navigator.pop(context); onPoll?.call(); }),
            _PlusItem(icon: '💰', label: '더치페이', onTap: () { Navigator.pop(context); onDutchPay?.call(); }),
            const _Section('게임'),
            _PlusItem(icon: '🎲', label: '랜덤 순서', onTap: () { Navigator.pop(context); onRandomOrder?.call(); }),
            _PlusItem(icon: '❓', label: '랜덤 질문', onTap: () { Navigator.pop(context); onRandomQuestion?.call(); }),
            _PlusItem(icon: '😂', label: '밸런스 게임', onTap: () { Navigator.pop(context); onBalance?.call(); }),
            _PlusItem(icon: '🎭', label: '역할 배정', onTap: () { Navigator.pop(context); onRoleAssign?.call(); }),
            _PlusItem(icon: '💺', label: '자리 정하기', onTap: () { Navigator.pop(context); onSeatShuffle?.call(); }),
            _PlusItem(icon: '🎫', label: '제비뽑기', onTap: () { Navigator.pop(context); onDrawLots?.call(); }),
            _PlusItem(icon: '👀', label: '눈치 게임', sound: true, onTap: () { Navigator.pop(context); onNunchi?.call(); }),
            _PlusItem(icon: '🔤', label: '초성 게임', sound: true, onTap: () { Navigator.pop(context); onChoseong?.call(); }),
            _PlusItem(icon: '⬆️', label: '업다운 게임', sound: true, onTap: () { Navigator.pop(context); onUpdown?.call(); }),
            _PlusItem(icon: '🎭', label: '몸으로 말해요', sound: true, onTap: () { Navigator.pop(context); onCharades?.call(); }),
            const SizedBox(height: 20),
          ]),
        ),
      ]),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  const _Section(this.title);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
    child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF9CA3AF))),
  );
}

class _PlusItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool sound;
  final VoidCallback? onTap;
  const _PlusItem({required this.icon, required this.label, this.sound = false, this.onTap});

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Text(icon, style: const TextStyle(fontSize: 20)),
    title: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
    trailing: sound ? const Text('🔊', style: TextStyle(fontSize: 12, color: Color(0xFFD1D5DB))) : null,
    onTap: onTap,
    dense: true,
  );
}

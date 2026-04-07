import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'matching/matching_screen.dart';
import 'chat/chat_list_screen.dart';
import 'profile/profile_screen.dart';

/// 메인 탭 네비게이션 셸 — 하단 네비로 4개 탭 전환
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        HomeScreen(navIndex: _currentIndex, onNavTap: _onNavTap),
        MatchingScreen(navIndex: _currentIndex, onNavTap: _onNavTap),
        ChatListScreen(navIndex: _currentIndex, onNavTap: _onNavTap),
        ProfileScreen(navIndex: _currentIndex, onNavTap: _onNavTap),
      ],
    );
  }
}

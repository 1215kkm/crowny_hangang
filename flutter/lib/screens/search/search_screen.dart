import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../config/app_config.dart';
import '../../mock/mock_data.dart';
import '../../widgets/gradient_icon_box.dart';

/// 검색 화면 — 채팅방/사용자 탭 검색
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 검색 헤더
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.arrow_back_rounded, size: 20, color: Color(0xFF6B7280)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                      decoration: InputDecoration(
                        hintText: '채팅방, 사용자 검색...',
                        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      style: const TextStyle(fontSize: 15, color: CrownyTheme.textPrimary),
                    ),
                  ),
                ],
              ),
            ),

            // 탭
            TabBar(
              controller: _tabController,
              labelColor: CrownyTheme.primary,
              unselectedLabelColor: const Color(0xFF9CA3AF),
              labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              indicatorColor: CrownyTheme.primary,
              tabs: const [Tab(text: '채팅방'), Tab(text: '사용자')],
            ),

            // 결과
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _RoomResults(query: _query),
                  _UserResults(query: _query),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomResults extends StatelessWidget {
  final String query;
  const _RoomResults({required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return const _EmptySearch();
    final rooms = MockData.moimRooms.where((r) =>
        r.title.toLowerCase().contains(query) || r.creatorNickname.toLowerCase().contains(query)).toList();
    if (rooms.isEmpty) return const _NoResults();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: rooms.length,
      itemBuilder: (_, i) {
        final r = rooms[i];
        return ListTile(
          leading: Container(
            width: 24, height: 24,
            decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.group_rounded, size: 14, color: Colors.white),
          ),
          title: Text(r.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          subtitle: Text('${r.creatorNickname} · ${r.district} · ${r.currentPeople}/${r.maxPeople}명', style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
          onTap: () => Navigator.pushNamed(context, '/chat-room', arguments: r),
        );
      },
    );
  }
}

class _UserResults extends StatelessWidget {
  final String query;
  const _UserResults({required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return const _EmptySearch();
    final users = MockData.nearbyUsers.where((u) => u.nickname.toLowerCase().contains(query)).toList();
    if (users.isEmpty) return const _NoResults();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: users.length,
      itemBuilder: (_, i) {
        final u = users[i];
        return ListTile(
          leading: Container(
            width: 24, height: 24,
            decoration: BoxDecoration(color: CrownyTheme.primary, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.person_rounded, size: 14, color: Colors.white),
          ),
          title: Text(u.nickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          subtitle: Text('${u.activityLabel} · ${u.distanceMeters}m', style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
          onTap: () => Navigator.pushNamed(context, '/user-profile', arguments: u),
        );
      },
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.search_rounded, size: 48, color: Color(0xFFD1D5DB)),
        SizedBox(height: 12),
        Text('검색어를 입력하세요', style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
      ]),
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('결과 없음', style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))));
  }
}

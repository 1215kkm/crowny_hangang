import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../models/board_model.dart';
import '../../mock/mock_board.dart';
import '../../widgets/gradient_icon_box.dart';
import 'board_detail_screen.dart';
import 'board_write_screen.dart';

class BoardListScreen extends StatefulWidget {
  const BoardListScreen({super.key});

  @override
  State<BoardListScreen> createState() => _BoardListScreenState();
}

class _BoardListScreenState extends State<BoardListScreen> {
  String _selectedDistrict = 'all';
  String _selectedCategory = 'free';

  List<BoardPost> get _filteredPosts {
    return MockBoard.posts.where((p) {
      if (_selectedDistrict != 'all' && p.district != _selectedDistrict) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CrownyTheme.bgPage,
      body: Container(
        decoration: const BoxDecoration(gradient: CrownyTheme.bgGradient),
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 헤더
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40, height: 40,
                            decoration: CrownyTheme.iconButtonDecoration,
                            child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 22),
                          ),
                        ),
                        const Text('한강 게시판', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                        Container(
                          width: 40, height: 40,
                          decoration: CrownyTheme.iconButtonDecoration,
                          child: const Icon(Icons.search_rounded, color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 지역 탭 (가로 스크롤)
                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: HangangDistrict.labels.entries.map((e) {
                          final isActive = e.key == _selectedDistrict;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedDistrict = e.key),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                e.value,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isActive ? CrownyTheme.primary : Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // 하단 흰색 시트
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(CrownyTheme.radiusXl)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 4),
                      child: Container(width: 36, height: 4, decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(2))),
                    ),

                    // 카테고리 필터
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                      child: SizedBox(
                        height: 32,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: BoardCategory.labels.entries.map((e) {
                            final isActive = e.key == _selectedCategory;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedCategory = e.key),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isActive ? CrownyTheme.primary.withValues(alpha: 0.1) : const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(8),
                                  border: isActive ? Border.all(color: CrownyTheme.primary.withValues(alpha: 0.3)) : null,
                                ),
                                child: Text(
                                  e.value,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isActive ? CrownyTheme.primary : CrownyTheme.textMuted,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    // 게시글 리스트
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
                        itemCount: _filteredPosts.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF3F4F6)),
                        itemBuilder: (context, i) => _PostTile(
                          post: _filteredPosts[i],
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_) => BoardDetailScreen(post: _filteredPosts[i]),
                            ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const BoardWriteScreen()));
        },
        backgroundColor: CrownyTheme.primary,
        elevation: 4,
        child: const Icon(Icons.edit_rounded, color: Colors.white),
      ),
    );
  }
}

class _PostTile extends StatelessWidget {
  final BoardPost post;
  final VoidCallback onTap;
  const _PostTile({required this.post, required this.onTap});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    return '${diff.inDays}일 전';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 작성자 + 지역 + 시간
            Row(
              children: [
                GradientIconBox(
                  icon: _getIcon(post.authorIcon),
                  gradientType: post.authorGradient,
                  size: 28, iconSize: 14, borderRadius: 8,
                ),
                const SizedBox(width: 8),
                Text(post.authorNickname, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: CrownyTheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    HangangDistrict.labels[post.district] ?? post.district,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: CrownyTheme.primary),
                  ),
                ),
                const Spacer(),
                Text(_timeAgo(post.createdAt), style: const TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
              ],
            ),
            const SizedBox(height: 10),

            // 제목
            Text(post.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
            const SizedBox(height: 4),

            // 내용 미리보기
            Text(
              post.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: CrownyTheme.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 10),

            // 좋아요, 댓글, 조회수
            Row(
              children: [
                Icon(Icons.favorite_rounded, size: 14, color: CrownyTheme.textMuted),
                const SizedBox(width: 3),
                Text('${post.likeCount}', style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                const SizedBox(width: 14),
                Icon(Icons.chat_bubble_rounded, size: 13, color: CrownyTheme.textMuted),
                const SizedBox(width: 3),
                Text('${post.commentCount}', style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                const SizedBox(width: 14),
                Icon(Icons.visibility_rounded, size: 14, color: CrownyTheme.textMuted),
                const SizedBox(width: 3),
                Text('${post.viewCount}', style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String name) {
    const map = {
      'sports_bar': Icons.sports_bar_rounded,
      'directions_run': Icons.directions_run_rounded,
      'photo_camera': Icons.photo_camera_rounded,
      'pets': Icons.pets_rounded,
      'nightlight': Icons.nightlight_rounded,
      'local_cafe': Icons.local_cafe_rounded,
    };
    return map[name] ?? Icons.person_rounded;
  }
}

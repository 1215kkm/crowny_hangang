import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../models/board_model.dart';
import '../../mock/mock_board.dart';
import '../../widgets/gradient_icon_box.dart';

class BoardDetailScreen extends StatelessWidget {
  final BoardPost post;
  const BoardDetailScreen({super.key, required this.post});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    return '${diff.inDays}일 전';
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

  @override
  Widget build(BuildContext context) {
    final comments = MockBoard.commentsForB1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: CrownyTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert_rounded, color: CrownyTheme.textMuted), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 작성자
                  Row(
                    children: [
                      GradientIconBox(icon: _getIcon(post.authorIcon), gradientType: post.authorGradient, size: 40, iconSize: 20, borderRadius: 12),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.authorNickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                            Row(
                              children: [
                                Text(HangangDistrict.labels[post.district] ?? '', style: TextStyle(fontSize: 11, color: CrownyTheme.primary, fontWeight: FontWeight.w600)),
                                const SizedBox(width: 6),
                                Text(_timeAgo(post.createdAt), style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: CrownyTheme.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          BoardCategory.labels[post.category] ?? '',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CrownyTheme.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 제목
                  Text(post.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary, height: 1.4)),
                  const SizedBox(height: 14),

                  // 내용
                  Text(post.content, style: const TextStyle(fontSize: 15, color: CrownyTheme.textSecondary, height: 1.7)),
                  const SizedBox(height: 24),

                  // 좋아요, 댓글, 조회수
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Color(0xFFF3F4F6)))),
                    child: Row(
                      children: [
                        _StatButton(icon: Icons.favorite_rounded, count: post.likeCount, label: '좋아요', isActive: false),
                        const SizedBox(width: 24),
                        _StatButton(icon: Icons.chat_bubble_rounded, count: post.commentCount, label: '댓글'),
                        const SizedBox(width: 24),
                        _StatButton(icon: Icons.visibility_rounded, count: post.viewCount, label: '조회'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 댓글 섹션
                  Text('댓글 ${comments.length}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                  const SizedBox(height: 14),

                  ...comments.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientIconBox(icon: _getIcon(c.authorIcon), gradientType: c.authorGradient, size: 32, iconSize: 16, borderRadius: 10),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(c.authorNickname, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                                  const SizedBox(width: 6),
                                  Text(_timeAgo(c.createdAt), style: const TextStyle(fontSize: 10, color: CrownyTheme.textMuted)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(c.content, style: const TextStyle(fontSize: 13, color: CrownyTheme.textSecondary, height: 1.5)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.favorite_border_rounded, size: 14, color: CrownyTheme.textMuted),
                                  const SizedBox(width: 3),
                                  Text('${c.likeCount}', style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                                  const SizedBox(width: 14),
                                  Text('답글', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CrownyTheme.textMuted)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),

          // 댓글 입력
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, MediaQuery.of(context).padding.bottom + 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: CrownyTheme.bgCard,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text('댓글을 입력하세요...', style: TextStyle(fontSize: 13, color: CrownyTheme.textMuted)),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    gradient: CrownyTheme.buttonGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatButton extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  final bool isActive;
  const _StatButton({required this.icon, required this.count, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isActive ? CrownyTheme.secondary : CrownyTheme.textMuted),
        const SizedBox(width: 4),
        Text('$count', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isActive ? CrownyTheme.secondary : CrownyTheme.textMuted)),
      ],
    );
  }
}

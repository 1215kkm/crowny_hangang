import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../models/board_model.dart';
import '../../widgets/gradient_button.dart';

class BoardWriteScreen extends StatefulWidget {
  const BoardWriteScreen({super.key});

  @override
  State<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends State<BoardWriteScreen> {
  String _district = 'yeouido';
  String _category = 'free';
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: CrownyTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('글 쓰기', style: TextStyle(fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary, fontSize: 16)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GradientButton(
              text: '등록',
              isSmall: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('게시글이 등록되었습니다!'),
                    backgroundColor: CrownyTheme.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 지역 선택
            const Text('지역', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: HangangDistrict.labels.entries.where((e) => e.key != 'all').map((e) {
                final isActive = e.key == _district;
                return GestureDetector(
                  onTap: () => setState(() => _district = e.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive ? CrownyTheme.primary : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(e.value, style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : CrownyTheme.textSecondary,
                    )),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 카테고리 선택
            const Text('카테고리', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: BoardCategory.labels.entries.map((e) {
                final isActive = e.key == _category;
                return GestureDetector(
                  onTap: () => setState(() => _category = e.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive ? CrownyTheme.primary : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(e.value, style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : CrownyTheme.textSecondary,
                    )),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // 제목
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary),
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요',
                hintStyle: TextStyle(color: CrownyTheme.textMuted, fontWeight: FontWeight.w500),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const Divider(color: Color(0xFFF3F4F6)),
            const SizedBox(height: 8),

            // 내용
            TextField(
              controller: _contentController,
              maxLines: null,
              minLines: 10,
              style: const TextStyle(fontSize: 15, color: CrownyTheme.textSecondary, height: 1.7),
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요...\n\n한강에서의 이야기를 공유해보세요!',
                hintStyle: TextStyle(color: CrownyTheme.textMuted, fontWeight: FontWeight.w400),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 24),

            // 사진 추가
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(14),
                  color: CrownyTheme.bgCard,
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_photo_alternate_rounded, size: 32, color: CrownyTheme.textMuted),
                    const SizedBox(height: 6),
                    const Text('사진 추가', style: TextStyle(fontSize: 13, color: CrownyTheme.textMuted)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

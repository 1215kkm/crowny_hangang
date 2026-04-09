import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../config/app_config.dart';
import '../../models/chat_model.dart';

/// 모집글 작성 화면
class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  String _district = '';
  int _people = 3;
  bool _isPublic = true;
  String _selectedMission = 'none';

  @override
  void initState() {
    super.initState();
    _district = AppConfig.districtNames.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close_rounded, color: Color(0xFF6B7280)), onPressed: () => Navigator.pop(context)),
        title: const Text('모집글 작성', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('모집글이 등록되었습니다!')));
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(gradient: CrownyTheme.primaryGradient, borderRadius: BorderRadius.circular(12)),
                child: const Text('등록', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            decoration: InputDecoration(
              hintText: '제목을 입력하세요',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
            ),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: '어떤 모임인지 설명해주세요...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD1D5DB))),
            ),
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),

          // 지역 선택
          const Text('지역 선택', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: AppConfig.districtNames.map((d) => ChoiceChip(
            label: Text(d), selected: _district == d,
            selectedColor: const Color(0xFFF3F0FF),
            onSelected: (_) => setState(() => _district = d),
          )).toList()),
          const SizedBox(height: 20),

          // 모집 인원
          const Text('모집 인원', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          const SizedBox(height: 8),
          Row(children: [
            IconButton(onPressed: () => setState(() => _people = (_people - 1).clamp(2, 10)), icon: const Icon(Icons.remove_circle_outline_rounded)),
            Text('$_people', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            IconButton(onPressed: () => setState(() => _people = (_people + 1).clamp(2, 10)), icon: const Icon(Icons.add_circle_outline_rounded)),
            const Text('명', style: TextStyle(color: Color(0xFF9CA3AF))),
          ]),
          const SizedBox(height: 16),

          // 공개/비공개
          SwitchListTile(
            title: const Text('공개방', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            subtitle: Text(_isPublic ? '누구나 바로 입장할 수 있어요' : '손흔들기 후 방장이 수락해야 입장 가능', style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            value: _isPublic,
            onChanged: (v) => setState(() => _isPublic = v),
            activeColor: CrownyTheme.primary,
          ),
          const SizedBox(height: 16),

          // 미션 선택
          const Text('미션 선택 (선택사항)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
          const SizedBox(height: 8),
          ...PresetMission.presets.map((m) => RadioListTile<String>(
            title: Text(m.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            subtitle: Text(m.description, style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            value: m.type, groupValue: _selectedMission,
            onChanged: (v) => setState(() => _selectedMission = v!),
            activeColor: CrownyTheme.primary, dense: true,
          )),
        ]),
      ),
    );
  }
}

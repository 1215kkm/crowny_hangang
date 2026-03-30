import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app/theme.dart';

/// 보라 그라데이션 배경 + 흰 바텀시트 구조의 기본 스캐폴드
class PurpleScaffold extends StatelessWidget {
  final Widget? topContent; // 보라 배경 위 콘텐츠
  final Widget? sheetContent; // 흰 바텀시트 콘텐츠
  final Widget? bottomNav;
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final bool showHandle; // 바텀시트 핸들 표시

  const PurpleScaffold({
    super.key,
    this.topContent,
    this.sheetContent,
    this.bottomNav,
    this.title,
    this.leading,
    this.trailing,
    this.showHandle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: CrownyTheme.bgPurple,
        body: Container(
          decoration: const BoxDecoration(gradient: CrownyTheme.bgGradient),
          child: Column(
            children: [
              // 상단 영역 (보라 배경)
              SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 헤더 바
                    if (title != null || leading != null || trailing != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: CrownyTheme.pagePadding,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            leading ?? const SizedBox(width: 40),
                            if (title != null)
                              Text(
                                title!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            trailing ?? const SizedBox(width: 40),
                          ],
                        ),
                      ),
                    // 추가 상단 콘텐츠
                    if (topContent != null) topContent!,
                  ],
                ),
              ),

              // 하단 흰 시트
              if (sheetContent != null)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(CrownyTheme.radiusXl)),
                    ),
                    child: Column(
                      children: [
                        if (showHandle)
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 8),
                            child: Container(
                              width: 36,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(
                              CrownyTheme.pagePadding,
                              8,
                              CrownyTheme.pagePadding,
                              100,
                            ),
                            child: sheetContent!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNav,
      ),
    );
  }
}

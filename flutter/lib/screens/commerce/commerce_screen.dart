import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../mock/mock_commerce.dart';
import '../../models/commerce_model.dart';
import '../../widgets/gradient_icon_box.dart';
import 'commerce_detail_screen.dart';

class CommerceScreen extends StatefulWidget {
  const CommerceScreen({super.key});

  @override
  State<CommerceScreen> createState() => _CommerceScreenState();
}

class _CommerceScreenState extends State<CommerceScreen> {
  String _selectedCategory = 'delivery';

  @override
  Widget build(BuildContext context) {
    final items = MockCommerce.getItemsByCategory(_selectedCategory);

    return Scaffold(
      backgroundColor: CrownyTheme.bgPage,
      body: Container(
        decoration: const BoxDecoration(gradient: CrownyTheme.bgGradient),
        child: Column(
          children: [
            // 상단 보라 영역
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
                        const Text('한강 주문', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                        Container(
                          width: 40, height: 40,
                          decoration: CrownyTheme.iconButtonDecoration,
                          child: const Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 위치 표시
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on_rounded, size: 16, color: Colors.white.withValues(alpha: 0.9)),
                          const SizedBox(width: 6),
                          Text('여의도 한강공원 2지구로 배달', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.9))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 카테고리
                    SizedBox(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: MockCommerce.categories.map((cat) {
                          final isActive = cat.id == _selectedCategory;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedCategory = cat.id),
                            child: Column(
                              children: [
                                Container(
                                  width: 54, height: 54,
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.18),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    _getCatIcon(cat.icon),
                                    size: 26,
                                    color: isActive ? CrownyTheme.primary : Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cat.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                    color: Colors.white.withValues(alpha: isActive ? 1 : 0.7),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            // 하단 흰색 시트
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(CrownyTheme.radiusXl)),
                ),
                child: Column(
                  children: [
                    // 핸들
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Container(width: 36, height: 4, decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(2))),
                    ),
                    // 인기 배너
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFFFFF7ED), Color(0xFFFEF3C7)]),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Row(
                          children: [
                            const Text('🔥', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('같이 시키면 배달비 무료!', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
                                  SizedBox(height: 2),
                                  Text('매칭 상대와 함께 주문하세요', style: TextStyle(fontSize: 11, color: Color(0xFFB45309))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 아이템 리스트
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, i) => _ItemCard(item: items[i]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCatIcon(String name) {
    const map = {
      'delivery_dining': Icons.delivery_dining_rounded,
      'store': Icons.store_rounded,
      'card_giftcard': Icons.card_giftcard_rounded,
      'local_cafe': Icons.local_cafe_rounded,
    };
    return map[name] ?? Icons.shopping_bag_rounded;
  }
}

class _ItemCard extends StatelessWidget {
  final ShopItem item;
  const _ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CommerceDetailScreen(item: item)));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CrownyTheme.bgCard,
          borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
          border: Border.all(color: const Color(0xFFEDE9FE)),
        ),
        child: Row(
          children: [
            GradientIconBox(
              icon: _getIcon(item.imageIcon ?? 'restaurant'),
              gradientType: item.gradientType,
              size: 56, iconSize: 28, borderRadius: 16,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                      ),
                      if (item.isPopular)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: CrownyTheme.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('인기', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: CrownyTheme.accent)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(item.description, style: const TextStyle(fontSize: 12, color: CrownyTheme.textMuted)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(item.priceFormatted, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CrownyTheme.primary)),
                      const Spacer(),
                      Icon(Icons.star_rounded, size: 14, color: CrownyTheme.accent),
                      const SizedBox(width: 2),
                      Text('${item.rating}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CrownyTheme.textSecondary)),
                      const SizedBox(width: 8),
                      Text('주문 ${item.orderCount}', style: const TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String name) {
    const map = {
      'restaurant': Icons.restaurant_rounded,
      'local_pizza': Icons.local_pizza_rounded,
      'ramen_dining': Icons.ramen_dining_rounded,
      'sports_bar': Icons.sports_bar_rounded,
      'cookie': Icons.cookie_rounded,
      'coffee': Icons.coffee_rounded,
      'local_cafe': Icons.local_cafe_rounded,
      'card_giftcard': Icons.card_giftcard_rounded,
    };
    return map[name] ?? Icons.shopping_bag_rounded;
  }
}

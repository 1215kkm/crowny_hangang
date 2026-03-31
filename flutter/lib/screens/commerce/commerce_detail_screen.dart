import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../models/commerce_model.dart';
import '../../widgets/gradient_icon_box.dart';
import '../../widgets/gradient_button.dart';

class CommerceDetailScreen extends StatefulWidget {
  final ShopItem item;
  const CommerceDetailScreen({super.key, required this.item});

  @override
  State<CommerceDetailScreen> createState() => _CommerceDetailScreenState();
}

class _CommerceDetailScreenState extends State<CommerceDetailScreen> {
  int _quantity = 1;
  bool _isGift = false;

  int get _totalPrice => widget.item.price * _quantity;

  String _formatPrice(int price) {
    final str = price.toString();
    final buf = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buf.write(',');
      buf.write(str[i]);
    }
    return '${buf}원';
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: CrownyTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상품 아이콘
            Center(
              child: GradientIconBox(
                icon: _getIcon(item.imageIcon ?? 'restaurant'),
                gradientType: item.gradientType,
                size: 100, iconSize: 50, borderRadius: 28,
              ),
            ),
            const SizedBox(height: 24),

            // 상품명 + 설명
            Center(child: Text(item.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary))),
            const SizedBox(height: 6),
            Center(child: Text(item.description, style: const TextStyle(fontSize: 14, color: CrownyTheme.textMuted))),
            const SizedBox(height: 8),
            // 평점 + 주문수
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded, size: 16, color: CrownyTheme.accent),
                  const SizedBox(width: 3),
                  Text('${item.rating}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.textSecondary)),
                  const SizedBox(width: 12),
                  Icon(Icons.shopping_bag_rounded, size: 14, color: CrownyTheme.textMuted),
                  const SizedBox(width: 3),
                  Text('${item.orderCount}회 주문', style: const TextStyle(fontSize: 13, color: CrownyTheme.textMuted)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 가격
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: CrownyTheme.bgCard,
                borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Text('가격', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                  const Spacer(),
                  Text(item.priceFormatted, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: CrownyTheme.primary)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 수량
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: CrownyTheme.bgCard,
                borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Text('수량', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                  const Spacer(),
                  _QuantityButton(
                    icon: Icons.remove_rounded,
                    onTap: () { if (_quantity > 1) setState(() => _quantity--); },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: CrownyTheme.textPrimary)),
                  ),
                  _QuantityButton(
                    icon: Icons.add_rounded,
                    onTap: () => setState(() => _quantity++),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 선물하기 토글
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: CrownyTheme.bgCard,
                borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
              ),
              child: Row(
                children: [
                  GradientIconBox(icon: Icons.card_giftcard_rounded, gradientType: 'orange', size: 36, iconSize: 18, borderRadius: 10),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('매칭 상대에게 선물하기', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CrownyTheme.textPrimary)),
                        Text('상대방에게 마음을 전해보세요', style: TextStyle(fontSize: 11, color: CrownyTheme.textMuted)),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: _isGift,
                    onChanged: (v) => setState(() => _isGift = v),
                    activeColor: CrownyTheme.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 배달 정보
            const Text('배달 정보', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
            const SizedBox(height: 10),
            _InfoRow(icon: Icons.location_on_rounded, text: '여의도 한강공원 2지구'),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.timer_rounded, text: '예상 배달 시간: 30~40분'),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.local_shipping_rounded, text: '배달비: 3,000원 (같이 주문 시 무료)'),
            const SizedBox(height: 32),

            // 총 금액
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFF8F6FF), Color(0xFFF3F0FF)]),
                borderRadius: BorderRadius.circular(CrownyTheme.radiusMd),
                border: Border.all(color: const Color(0xFFEDE9FE)),
              ),
              child: Row(
                children: [
                  const Text('총 결제 금액', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: CrownyTheme.textPrimary)),
                  const Spacer(),
                  Text(_formatPrice(_totalPrice), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: CrownyTheme.primary)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 주문 버튼
            SizedBox(
              width: double.infinity,
              child: GradientButton(
                text: _isGift ? '선물하기 · ${_formatPrice(_totalPrice)}' : '주문하기 · ${_formatPrice(_totalPrice)}',
                icon: _isGift ? Icons.card_giftcard_rounded : Icons.shopping_cart_rounded,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isGift ? '선물이 전달되었습니다! 🎁' : '주문이 접수되었습니다! 🍗'),
                      backgroundColor: CrownyTheme.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
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

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: CrownyTheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: CrownyTheme.primary),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: CrownyTheme.textMuted),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, color: CrownyTheme.textSecondary)),
      ],
    );
  }
}

class ShopCategory {
  final String id;
  final String name;
  final String icon; // Material icon name
  final String gradientType;

  const ShopCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.gradientType,
  });
}

class ShopItem {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final int price;
  final String? imageIcon; // Material icon name
  final String gradientType;
  final bool isPopular;
  final double rating;
  final int orderCount;

  const ShopItem({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    this.imageIcon,
    this.gradientType = 'purple',
    this.isPopular = false,
    this.rating = 0,
    this.orderCount = 0,
  });

  String get priceFormatted {
    final str = price.toString();
    final buf = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buf.write(',');
      buf.write(str[i]);
    }
    return '${buf}원';
  }
}

class CartItem {
  final ShopItem item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  int get totalPrice => item.price * quantity;
}

class Order {
  final String id;
  final List<CartItem> items;
  final int totalPrice;
  final String status; // pending, preparing, delivering, completed
  final DateTime createdAt;
  final String? recipientNickname; // 선물하기 시

  const Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.recipientNickname,
  });
}

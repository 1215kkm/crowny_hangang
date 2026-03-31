import '../models/commerce_model.dart';

class MockCommerce {
  MockCommerce._();

  static const List<ShopCategory> categories = [
    ShopCategory(id: 'delivery', name: '배달 음식', icon: 'delivery_dining', gradientType: 'pink'),
    ShopCategory(id: 'convenience', name: '편의점 픽업', icon: 'store', gradientType: 'blue'),
    ShopCategory(id: 'gift', name: '선물하기', icon: 'card_giftcard', gradientType: 'orange'),
    ShopCategory(id: 'drink', name: '음료', icon: 'local_cafe', gradientType: 'purple'),
  ];

  static const List<ShopItem> deliveryItems = [
    ShopItem(
      id: 'd1', categoryId: 'delivery',
      name: '교촌 허니콤보', description: '바삭한 교촌의 대표 메뉴',
      price: 20000, imageIcon: 'restaurant', gradientType: 'pink',
      isPopular: true, rating: 4.8, orderCount: 328,
    ),
    ShopItem(
      id: 'd2', categoryId: 'delivery',
      name: 'BBQ 황금올리브', description: '겉바속촉 치킨의 정석',
      price: 21000, imageIcon: 'restaurant', gradientType: 'orange',
      isPopular: true, rating: 4.7, orderCount: 256,
    ),
    ShopItem(
      id: 'd3', categoryId: 'delivery',
      name: '도미노 포테이토 피자', description: '한강에서 먹는 피자',
      price: 18900, imageIcon: 'local_pizza', gradientType: 'pink',
      rating: 4.5, orderCount: 142,
    ),
    ShopItem(
      id: 'd4', categoryId: 'delivery',
      name: '족발보쌈 세트', description: '소주와 함께하는 야식',
      price: 32000, imageIcon: 'restaurant', gradientType: 'purple',
      rating: 4.6, orderCount: 98,
    ),
  ];

  static const List<ShopItem> convenienceItems = [
    ShopItem(
      id: 'c1', categoryId: 'convenience',
      name: '한강 라면 세트', description: '컵라면 2개 + 김밥 + 음료',
      price: 8500, imageIcon: 'ramen_dining', gradientType: 'orange',
      isPopular: true, rating: 4.9, orderCount: 512,
    ),
    ShopItem(
      id: 'c2', categoryId: 'convenience',
      name: '맥주 4캔 세트', description: '카스/테라/하이네켄/아사히',
      price: 12000, imageIcon: 'sports_bar', gradientType: 'blue',
      isPopular: true, rating: 4.7, orderCount: 423,
    ),
    ShopItem(
      id: 'c3', categoryId: 'convenience',
      name: '과자 파티팩', description: '새우깡+포카칩+꼬깔콘+칙촉',
      price: 7800, imageIcon: 'cookie', gradientType: 'pink',
      rating: 4.4, orderCount: 187,
    ),
  ];

  static const List<ShopItem> giftItems = [
    ShopItem(
      id: 'g1', categoryId: 'gift',
      name: '아이스 아메리카노', description: '매칭 상대에게 커피 한잔!',
      price: 4500, imageIcon: 'coffee', gradientType: 'purple',
      isPopular: true, rating: 5.0, orderCount: 892,
    ),
    ShopItem(
      id: 'g2', categoryId: 'gift',
      name: '편의점 간식 세트', description: '간단한 마음 전하기',
      price: 5000, imageIcon: 'card_giftcard', gradientType: 'orange',
      rating: 4.8, orderCount: 345,
    ),
    ShopItem(
      id: 'g3', categoryId: 'gift',
      name: '치킨 기프티콘', description: '다음에 같이 먹자!',
      price: 20000, imageIcon: 'restaurant', gradientType: 'pink',
      rating: 4.9, orderCount: 267,
    ),
  ];

  static const List<ShopItem> drinkItems = [
    ShopItem(
      id: 'dr1', categoryId: 'drink',
      name: '스타벅스 아메리카노', description: '한강 근처 매장 픽업',
      price: 4500, imageIcon: 'local_cafe', gradientType: 'purple',
      rating: 4.6, orderCount: 534,
    ),
    ShopItem(
      id: 'dr2', categoryId: 'drink',
      name: '밀크티 세트', description: '공차 버블티 2잔',
      price: 9800, imageIcon: 'local_cafe', gradientType: 'orange',
      rating: 4.5, orderCount: 178,
    ),
  ];

  static List<ShopItem> getItemsByCategory(String categoryId) {
    switch (categoryId) {
      case 'delivery': return deliveryItems;
      case 'convenience': return convenienceItems;
      case 'gift': return giftItems;
      case 'drink': return drinkItems;
      default: return [];
    }
  }
}

class Cart {
  final String title;
  final String imageUrl;
  final int discount;
  final int stock;
  final double price;

const Cart({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.discount,
    required this.stock
  });
}
